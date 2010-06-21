class Design < ActiveRecord::Base
  include WeeParser
  
  belongs_to :user
  
  attr_protected :user_id
  
  has_attached_file :header_image, :styles => { :header_format => "710x710>", :thumbnail => "70x70#" }, 
                                   :storage => :s3, 
                                   :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                   :path => ':attachment/:id/:style/:basename.:extension',
                                   :bucket => 'weefolio'
                                   
  has_one :theme
  
  after_create :set_html, :parse_browser_html
  
  def set_html
    if self.theme.blank?
      self.update_attribute(:user_html, IO.readlines("#{RAILS_ROOT}/public/themes/default-template.html").to_s)
    else
      self.update_attribute(:user_html, IO.readlines("#{RAILS_ROOT}/public/themes/#{self.theme.directory_name}/#{self.theme.template_filename}").to_s)
    end
  end
  
  def parse_browser_html
    self.update_attribute(:browser_html, WeeParser.build_erb_copy_for(WeeParser.parse(self.user_html), self.user_html))
  end
  
  # Virtual attribute from user.design_type
  def design_type
    self.user.design_type
  end
  
  # Change layout type
  def set_layout_type(number)
    self.layout_type -= self.layout_type
    self.layout_type += number
  end
  
  # Explicit decalration of layout type
  def render_layout_type
    if self.layout_type == 1
      "grid"
    else
      "list"
    end
  end
  
  # List of available font sizes for dropdowns
  def font_sizes
    font_sizes = [8, 10, 11, 12, 14, 16, 18, 20, 22, 24]
  end
  
  # List of  available font families for dropdowns
  def font_families
    font_families = ["Lucida Grande", "Arial", "Helvetica", "Times New Roman", "Courier", "Georgia", "Trebuchet MS", "Verdana"]
  end
  
  def render_color(color)
    if color.include?("#")
      "#{color}"
    else
      "##{color}"
    end
  end
  
  # THIS SHOULD BE A HASH!!!
  def render_font_family
    case self.font_family
    when "Lucida Grande"
      "'Lucida Grande', Arial, sans-serif"
    when "Arial"
      "Arial, sans-serif"
    when "Helvetica"
      "Helvetica, Arial, sans-serif"
    when "Times New Roman"
      "Times, 'Times New Roman', serif"
    when "Courier"
      "'Courier New', Courier, monospace"
    when "Georgia"
      "Georgia, 'Times New Roman', serif"
    when "Verdana"
      "Verdana, 'Verdana Ref', sans-serif"
    when "Trebuchet MS"
      "'Trebuchet MS', Verdana, 'Verdana Ref', sans-serif"
    end
      
  end
  
end
