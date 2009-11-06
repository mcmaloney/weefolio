class MainPagesController < ApplicationController
  layout "template"
  def home
    @page_title = "Weefolio - Lil' portfolios for the rest of us!"
  end
  
  def directory
    @page_title = "Weefolio - Directory"
  end
  
  def help
    @page_title = "Weedolio - Help"
  end
  
  def contact
    @user = current_user
    @page_title = "Weefolio - Contact Us"
  end
  
  def terms_of_use
    @page_title = "Weefolio - Terms of Use"
  end
  
  def privacy_policy
    @page_title = "Weefolio - Privacy Policy"
  end
  
  def send_us_mail
    if logged_in?
      @user = User.find(params[:id])
      @from = @user.email
    else
      @from = params[:sender_email]
    end
    
    @subject = params[:subject]
    @message = params[:message]
    UserMailer.send_later :deliver_contact_message, @from, @subject, @message
    redirect_to contact_path
    flash[:notice] = "Thanks for your <strong>message</strong>. We'll get back to you as soon as possible."
  end
end
