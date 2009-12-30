module DesignsHelper
  def css_link(user)
    if user.design_type == 1
      %{<a href="/users/switch_design_type/#{@user.id}" id="custom_css_link">Edit Custom CSS</a>}
    else
      %{<a href=/users/switch_design_type/#{@user.id}" id="form_css_link">Edit Form CSS</a>}
    end
  end
end
