class Admin::UsersController < AdminController
  def index
    @users = User.paginate :page => params[:page], :order => "created_at DESC"
  end
end
