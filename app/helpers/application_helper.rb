# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def render_tag_line(user)
    content_tag(:h1, @user.tag_line) unless @user.tag_line.blank?
	end
	
	def image_preview_for(image)
	  unless image.size.blank?
	    image_tag image.url(:thumbnail)
	  end
	end
	
	def is_active?(action, controller)
		"selected" if params[:action] == action && params[:controller] == controller
	end
	
	def show_contact_form_for(user)
	  %{
	    <div id="contact-container">
			  #{flash[:notice]}
				
				#{form_tag :controller => 'portfolios', :action => 'send_message', :id => user, :html => { :method => :post }}
				  <fieldset>
						<label for="name">Name</label>
						#{text_field_tag :name}
					</fieldset>
					
					<fieldset>
						<label for="email">Email</label>
						#{text_field_tag :from}
					</fieldset>
					
					<fieldset>
						<label for="message">Message</label>
						<textarea id="message" name="message" rows="7"></textarea>
					</fieldset>
					
					<div id="contact-submit">
						#{submit_tag 'Send Message'}
					</div>
				</form>
			</div>
	  }
	end

	def show_about_me_for(user)
	  if user.about_me.blank?
	    %{
        <p>
    		  <strong>#{@user.login}</strong> hasn't added any information yet.
    		</p>
    	}
		else
		  %{
	      <div id="about-container">
					<p>
					  #{@user.about_me}
					</p>
				</div>
			}
		end
	end
	
	def render_wee_scripts
	  "#{javascript_include_tag 'jquery-1.3.1.min.js'}
	  <script type=\"text/javascript\">
    	  /** Switches the thumb into the full size view in the gallery. */
        function switch_large_image(image_path, piece) {
        	var source = image_path.id;
        	var full_size = '#' + piece
        	$(full_size).empty();
        	$('<img src=' + source + '>').appendTo(full_size);
        	$(full_size).fadeIn();
        }
      </script>"
	end
	
end
