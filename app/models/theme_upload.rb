class ThemeUpload < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :screenshot, :styles => { :thumbnail => "150x230#" },
                                            :storage => :s3, 
                                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                            :path => ':attachment/:id/:style/:basename.:extension'
  has_attached_file :asset_package, :storage => :s3, 
                                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                    :path => ':attachment/:id/:style/:basename.:extension'
                                    
  validates_less_reverse_captcha
  
  after_save :send_admin_email
  
  def send_admin_email
    UserMailer.deliver_theme_upload_message(self, self.user)
  end
end
