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
      if current_user.design.update_attribute(:theme, @theme)
        # TO-DO: Make these following two methods an after_update in design.rb
        current_user.design.set_html
        current_user.design.parse_browser_html
        # 
        redirect_to themes_path
        flash[:notice] = "Installed the #{@theme.name} theme."
      else
        render :action => 'index'
        flash[:notice] = "Sorry, but something went wrong. Try again?"
      end
    else
      redirect_to signup_path
      flash[:notice] = "You need a Weefolio to do that. Sign up now!"
    end
  end
end
