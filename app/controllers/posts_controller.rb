class PostsController < InheritedResources::Base
  before_filter :authorize, :except => [:index, :show]
  
  def destroy
    super do |format|
      format.html {redirect_to posts_path, flash[:notice] = "'#{@post.title}' deleted."}
    end
  end
  
  def update
    super do |format|
      format.html {redirect_to post_path(@post), flash[:notice] = "Post updated."}
    end
  end
  
  def create
    super do |format|
      format.html {redirect_to posts_path, flash[:notice] = "Published '#{@post.title}'"}
    end
  end
end
