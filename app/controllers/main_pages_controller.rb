class MainPagesController < ApplicationController
  def home
    @user = current_user
  end

end
