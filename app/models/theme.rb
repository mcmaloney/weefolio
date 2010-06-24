class Theme < ActiveRecord::Base
  include WeeParser
  
  has_many :designs
  
  has_attached_file :photo, :styles => { :thumbnail => "230x150#", :small => "50x50#" }, 
                            :storage => :s3, 
                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                            :path => ':attachment/:id/:style/:basename.:extension',
                            :bucket => 'weefolio'
  
  # Shows the path in admin so we can reference for adding stuff to the filesystem.                                
  def pathname
    "public/themes/#{self.directory_name}/#{self.template_filename}"
  end
  
  # Checks if the info we entered in the admin jives with the fileystem.
  def connected?
    File.exist?("#{RAILS_ROOT}/public/themes/#{self.directory_name}/#{self.template_filename}")
  end
  
  def render_preview
    html = IO.readlines("#{RAILS_ROOT}/public/themes/#{self.directory_name}/#{self.template_filename}").to_s
    WeeParser.build_erb_copy_for(WeeParser.parse(html), html)
  end
  
end
