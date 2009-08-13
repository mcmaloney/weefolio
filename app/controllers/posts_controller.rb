class PostsController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  
  def index
    @posts = Post.find(:all)
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create!(params[:post])
    if @post.save
      redirect_to posts_path
      flash[:notice] = "Published '#{@post.title}'"
    else
      render :action => 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to post_path(@post)
      flash[:notice] = "Post updated."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:notice] = "'#{@post.title}' deleted."
  end
end
