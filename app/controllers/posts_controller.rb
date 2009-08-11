class PostsController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  
  def index
    @posts = Post.find(:all)
  end

  def new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

end
