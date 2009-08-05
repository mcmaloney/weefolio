class Design < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :header_image, :styles => { :header_format => "710x100" }
  
  # Virtual attribute from user.design_type
  def design_type
    self.user.design_type
  end
end
