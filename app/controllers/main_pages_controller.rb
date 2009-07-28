class MainPagesController < ApplicationController
  layout "template"
  
  def home
    @page_title = "Weefolio :: Home"
  end
end
