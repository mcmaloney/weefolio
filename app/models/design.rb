class Design < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :header_image, :styles => { :header_format => "710x100" }
  
  # Virtual attribute from user.design_type
  def design_type
    self.user.design_type
  end
  
  def render_serif(element)
    if element
      "serif"
    else
      "sans-serif"
    end
  end
  
  def render_italic(element)
    if element
      "italic"
    else
      "normal"
    end
  end
  
  def render_bold(element)
    if element
      "bold"
    else
      "normal"
    end
  end
end
