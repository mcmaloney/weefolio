class Admin::UsersController < AdminController
  def index
    @users = User.paginate :page => params[:page], :order => "created_at DESC"
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to admin_users_path
    flash[:notice] = "User deleted. 4EVA."
  end
end
