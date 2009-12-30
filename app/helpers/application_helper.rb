# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def render_tag_line(user)
    if @user.tag_line.blank?
      content_tag(:h1, "Hello! My name is <a href='#'>#{@user.login}</a> and this is my Weefolio!")
		else
	    content_tag(:h1, @user.tag_line)
		end
	end
	
	def image_preview_for(image)
	  unless image.size.blank?
	    image_tag image.url(:thumbnail)
	  end
	end
end
