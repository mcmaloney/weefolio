class DesignsController < ApplicationController
  layout 'template'
  before_filter :login_required
  before_filter :get_user_design
  
  def edit
    @page_title = "Weefolio - Layout Editor"
  end

  def update
    if @design.update_attributes(params[:design]) 
      @design.parse_browser_html
      redirect_to edit_user_design_path(current_user, @design)
      flash[:notice] = "Your <strong>design</strong> has been saved."
    end
  end
  
  protected
  
  def get_user_design
    @user = current_user
    @design = current_user.design
  end
end
