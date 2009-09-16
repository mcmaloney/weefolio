module DesignsHelper
  def css_link(user)
    if user.design_type == 1
      link_to 'Edit Custom CSS', :controller => 'users', :action => 'switch_design_type', :id => @user.id
    else
      link_to 'Edit Form CSS', :controller => 'users', :action => 'switch_design_type', :id => @user.id
    end
  end
end
