class Design < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :header_image, :styles => { :header_format => "710x100" }
  
  # Virtual attribute from user.design_type
  def design_type
    self.user.design_type
  end
  
  # Change layout type
  def set_layout_type(number)
    self.layout_type -= self.layout_type
    self.layout_type += number
  end
  
  def render_layout_type
    if self.layout_type == 1
      "grid"
    else
      "list"
    end
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
  
  def render_font_size(font)
    "#{font.to_s}px"
  end
  
  def font_sizes
    font_sizes = [8, 10, 12, 14, 16, 18, 20, 22, 24]
  end
  
  def font_families
    font_families = ["Arial", "Helvetica", "Times New Roman", "Courier", "Georgia", "Trebuchet MS", "Verdana"]
  end
end
