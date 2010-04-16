class UserMailer < ActionMailer::Base  
  REGARDING = [["Report a Bug", "Bug Report"], ["Technical Help", "Technical Help"], ["General Inquiry", "General Inquiry"]]
  WEEFOLIO_ADMINS = "mcm@crushlovely.com"
  WEEFOLIO_SYSTEM = "user_destroyer@weefolio.com"
  
  # Message between users. (i.e. contact form on Weefolio page, etc.)
  def user_message(recip, from, from_name, message)
    recipients recip
    from from
    subject "Message from Weefolio User #{from_name}"
    sent_on Time.now
    body message
  end
  
  # We're using GetSatisfaction now.
  #
  # # Message for when someone contacts us from the contact page. Static recipient list.
  #  def contact_message(from, sender_name, subject, message)
  #    recipients WEEFOLIO_ADMINS
  #    from from
  #    subject "Message From Weefolio Contact Form - #{subject}"
  #    body :message => message, :sender_name => sender_name, :reply_email => from
  #  end
  
  def delete_account_message(user)
    recipients WEEFOLIO_ADMINS
    from WEEFOLIO_SYSTEM
    subject "DELETE USER ACCOUNT REQUEST"
    body :login => user.login, :email => user.email
  end
end
