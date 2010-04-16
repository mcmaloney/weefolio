class AdminController < ApplicationController
  before_filter :admin_only
end
