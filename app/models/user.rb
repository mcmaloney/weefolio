require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_one                   :portfolio
  has_one                   :design
  has_many                  :pieces, :through => :portfolio
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code 

  # Should really get rid of the account_tier from attr_accessible...
  attr_accessible :login, :email, :name, :password, :password_confirmation, :first_name, :last_name, :about_me, :tag_line, :design_type, :layout_type, :account_tier, :photo
  
  # Paperclip settings
  has_attached_file :photo, :styles => { :thumbnail => "70x70#", :large_thumb => "116x116#" }
  
  # Is this user an admin?
  def admin?
    self.admin_user
  end
  
  # Array of card types for payments.
  def card_types
    card_types = ["Visa", "Mastercard", "Discover", "American Express"]
  end
  
  # The ending year for credit card expiration year.
  def end_year
    Time.now.year + 20
  end
  
  # Upgrade account 
  def change_tier(tier)
    self.account_tier -= self.account_tier
    self.account_tier += tier
  end
  
  # Shows the text equivalent of the account tier for display to the user.
  def render_account_tier
    if self.account_tier == 1
      "Basic"
    elsif self.account_tier == 2
      "Plus"
    elsif self.account_tier == 3
      "Pro"
    end
  end
  
  # Change design type
  def set_design_type(number)
    self.design_type -= self.design_type
    self.design_type += number
  end
  
  def setup_portfolio_and_design
    my_portfolio = Portfolio.new
    self.portfolio = my_portfolio
    self.portfolio.save
    
    my_design_editor = Design.new
    self.design = my_design_editor
    self.design.save
  end

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end


end
