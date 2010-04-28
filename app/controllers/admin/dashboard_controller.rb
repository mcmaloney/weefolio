class Admin::DashboardController < AdminController
  def index
    @user_count = User.count
    render
  end
end
