require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PortfoliosController do

  #Delete these examples and add some real ones
  it "should use PortfoliosController" do
    controller.should be_an_instance_of(PortfoliosController)
  end


  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end
end
