module MainPagesHelper
  def show_sender_email
    unless logged_in?
      %{
        <dt>
        	<label for="sender_email">Your Email</label>
        </dt>
        <dd>
        	#{text_field_tag :sender_email}
        </dd>
      }
		end
	end
	
	def show_name_field
	  unless logged_in?
	    %{
	      <dt>
	        <label for="sender_name">Your Name</label>
	      </dt>
	      <dd>
	        #{text_field_tag :sender_name}
	      </dd>
	    }
	  end
	end
end
