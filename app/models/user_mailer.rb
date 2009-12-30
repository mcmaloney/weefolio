class UserMailer < ActionMailer::Base  
  REGARDING = [["Report a Bug", "Bug Report"], ["Technical Help", "Technical Help"], ["General Inquiry", "General Inquiry"]]
  
  # Message between users. (i.e. contact form on Weefolio page, etc.)
  def user_message(recip, from, from_name, message)
    recipients recip
    from from
    subject from_name
    sent_on Time.now
    body message
  end
  
  # Message for when someone contacts us from the contact page. Static recipient list.
  def contact_message(from, sender_name, subject, message)
    recipients "maloney.mc@gmail.com" # Change to weefolio address in production mode- using this for test.
    from from
    subject "Message From Weefolio Contact Form - #{subject}"
    body :message => message, :sender_name => sender_name, :reply_email => from
  end
end
