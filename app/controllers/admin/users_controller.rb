class Admin::UsersController < AdminController
  def index
    @users = User.paginate :page => params[:page], :order => "created_at DESC"
  end
  
  def show
    @user = User.find(params[:id])
  end
end
