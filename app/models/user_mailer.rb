class UserMailer < ActionMailer::Base  
  # Message between users. (i.e. contact form on Weefolio page, etc.)
  def user_message(recip, from, from_name, message)
    recipients recip
    from from
    subject from_name
    sent_on Time.now
    body message
  end
  
  # Message for when someone contacts us from the contact page. Static recipient list.
  def contact_message(from, subject, message)
    recipients "maloney.mc@gmail.com" # Change to weefolio address in production mode- using this for test.
    from from
    subject subject
    body message
  end
end
