require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_one                   :portfolio, :dependent => :destroy
  has_one                   :design, :dependent => :destroy
  has_one                   :plan, :dependent => :destroy
  has_many                  :pieces, :through => :portfolio
  has_many                  :theme_uploads
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
  
  validates_less_reverse_captcha

  # Should really get rid of the account_tier from attr_accessible...
  attr_accessible :login, :email, :name, :password, :password_confirmation, :first_name, :last_name, :about_me, :tag_line, :design_type, :layout_type, :photo
  
  # Paperclip settings
  has_attached_file :photo, :styles => { :thumbnail => "70x70#", :large_thumb => "116x116#" }, 
                            :storage => :s3, 
                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                            :path => ':attachment/:id/:style/:basename.:extension',
                            :bucket => 'weefolio'
  
  # Sets up all objects associated with the user on creation of account.
  def setup
    # Build the portfolio
    self.portfolio = Portfolio.new(:login => self.login)
    self.portfolio.save
    
    # Build the design editor
    self.design = Design.new
    self.design.save
    
    # Set the plan at level 1
    self.plan = Plan.new(:level => 1)
    self.plan.save
    
    # Activate
    self.activate!
    
    # Save the user at the end.
    self.save
  end
  
  # Checking for associated objects.
  def has_associated
    self.portfolio && self.design && self.plan
  end
  
  # Check if the plan and user attributes updated as well as the transaction processed.
  def update_self_and_plan(user, plan)
    if plan[:level].to_i == 1
      self.plan.attributes = plan
      self.plan.save(false)
      self.update_attributes(user)
    else
      self.plan.update_attributes(plan) && self.update_attributes(user) && self.plan.process_transaction
    end
  end
  
  # Simple search for the directory page
  def self.search(search, page)
    if search
      paginate :page => page, :per_page => 25, :order => "created_at DESC", :conditions => ['login LIKE ?', "%#{search}%"]
    else
      paginate :page => page, :per_page => 25, :order => "created_at DESC", :conditions => ['photo_file_size > ?', 0]
    end
  end
  
  # Is this user an admin?
  def admin?
    self.admin_user
  end
  
  # Array of card types for payments.
  def card_types
    card_types = ["Visa", "Mastercard", "Discover", "American Express"]
  end
  
  # Shows the text equivalent of the account tier for display to the user.
  def render_account_tier
    if self.plan.level == 1
      "Basic"
    elsif self.plan.level == 2
      "Plus ($4.99/Month)"
    elsif self.plan.level == 3
      "Pro ($9.99/Month)"
    end
  end
  
  # Change design type.
  def set_design_type(number)
    self.design_type -= self.design_type
    self.design_type += number
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
    write_attribute :login, (value ? value : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    
  def make_activation_code
    self.activation_code = self.class.make_token
  end
end
