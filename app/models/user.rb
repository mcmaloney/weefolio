require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_one                   :portfolio
  has_one                   :design
  has_many                  :pieces, :through => :portfolio
  validates_inclusion_of    :has_read_terms, :in => [true, false]
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

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :first_name, :last_name, :about_me, :tag_line, :design_type, :layout_type, :account_tier, :photo
  
  # Paperclip settings
  has_attached_file :photo
  
  # Is this user an admin?
  def admin?
    self.admin_user
  end
  
  # Change the user's password
  def change_password(new_password, email)
    if self.email == email
      self.password = new_password
      self.save
    else
      false
    end
  end
  
  # Upgrade account 
  def change_tier(tier)
    self.account_tier -= self.account_tier
    self.account_tier += tier
  end
  
  # Change design type
  def set_design_type(number)
    self.design_type -= self.design_type
    self.design_type += number
  end
   
  # Should probably put this in the Portfolio model (make_portfolio_for(user))
  def make_portfolio
    my_portfolio = Portfolio.new
    self.portfolio = my_portfolio
    self.portfolio.save
  end
  
  # Again, probably should be in Design model (make_design_for(user))
  def make_design_editor
    my_design_editor = Design.new
    self.design = my_design_editor
    self.design.save
  end
  
  # This is dumb. It bullies the user.
  def has_blank_info
    if (self.tag_line.blank? || self.about_me.blank?)
      return true
    else
      return false
    end
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
