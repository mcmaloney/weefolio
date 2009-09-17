class DesignsController < ApplicationController
  layout 'template'
  def edit
    @user = current_user
    @design = current_user.design
    @page_title = "Weefolio :: Layout Editor"
  end

  def update
    @design = current_user.design
    if @design.update_attributes(params[:design])
      redirect_to edit_user_design_path(current_user, @design)
      flash[:notice] = "Layout saved."
    end
  end
end
