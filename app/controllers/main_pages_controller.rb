class MainPagesController < ApplicationController
  layout "template"
  def home
    @page_title = "Weefolio :: Home"
  end
  
  def directory
    @page_title = "Weefolio :: Directory"
  end
  
  def help
    @page_title = "Weedolio :: Help"
  end
  
  def contact
    @page_title = "Weefolio :: Contact Us"
  end
  
  def terms_of_use
    @page_title = "Weefolio :: Terms of Use"
  end
  
  def privacy_policy
    @page_title = "Weefolio :: Privacy Policy"
  end
end
