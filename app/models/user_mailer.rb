class UserMailer < ActionMailer::Base  
  WEEFOLIO_ADMINS = "michael@fancylabs.com"
  WEEFOLIO_SYSTEM = "user_destroyer@weefolio.com"
  MIKE_AND_KEVIN = "michael@fancylabs.com, kevin@fancylabs.com"
  
  # Message between users. (i.e. contact form on Weefolio page, etc.)
  def user_message(recip, from, from_name, message)
    recipients recip
    from from
    subject "Message from Weefolio User #{from_name}"
    sent_on Time.now
    body :message => message
    content_type "text/html"
  end
  
  def delete_account_message(user)
    recipients WEEFOLIO_ADMINS
    from WEEFOLIO_SYSTEM
    subject "DELETE USER ACCOUNT REQUEST"
    body :login => user.login, :email => user.email
    content_type "text/html"
  end
  
  # Sends us a message when a theme gets uploaded
  def theme_upload_message(theme_upload, user)
    recipients MIKE_AND_KEVIN
    from "theme_upload_robot@weefolio.com"
    subject "New Theme Uploaded"
    sent_on Time.now
    body :theme_upload => theme_upload, :user => user
    content_type "text/html"
  end
end
