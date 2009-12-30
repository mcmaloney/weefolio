class Design < ActiveRecord::Base
  belongs_to :user
  
  attr_protected :user_id
  
  has_attached_file :header_image, :styles => { :header_format => "710x110#", :thumbnail => "70x70#" }
  
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
  
  # Set serif mode on a given element
  def render_serif(element)
    if element
      "serif"
    else
      "sans-serif"
    end
  end
  
  # Set italic mode on a given element
  def render_italic(element)
    if element
      "italic"
    else
      "normal"
    end
  end
  
  # Set bold on a given element
  def render_bold(element)
    if element
      "bold"
    else
      "normal"
    end
  end
  
  # Render the font size for use in dynamic CSS
  def render_font_size(font)
    "#{font.to_s}px"
  end
  
  # List of available font sizes for dropdowns
  def font_sizes
    font_sizes = [8, 10, 12, 14, 16, 18, 20, 22, 24]
  end
  
  # List of  available font families for dropdowns
  def font_families
    font_families = ["Arial", "Helvetica", "Times New Roman", "Courier", "Georgia", "Trebuchet MS", "Verdana"]
  end
  
  def render_color(color)
    if color.include?("#")
      "#{color}"
    else
      "##{color}"
    end
  end
end
