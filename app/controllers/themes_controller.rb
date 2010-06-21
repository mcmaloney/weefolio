class ThemesController < ApplicationController
  layout "template"
  
  def index
    @themes = Theme.all.paginate(:page => params[:page], :per_page => 9)
  end
  
  def show
    
  end
  
  def install
    @theme = Theme.find(params[:id])
    if current_user
      current_user.design.theme = @theme
      if current_user.design.theme.save
        redirect_to themes_path
        flash[:notice] = "Theme changed to #{@theme.name}"
      else
        render :action => 'index'
        flash[:notice] = "Sorry- something went wrong. Try again?"
      end
    else
      redirect_to signup_path
      flash[:notice] = "You need a Weefolio to pick a theme. Sign up now!"
    end
  end
end
