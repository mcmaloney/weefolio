module MainPagesHelper
  def show_sender_email
    unless logged_in?
     render :partial => 'sender_email_field'
		end
	end
end
