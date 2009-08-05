require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DesignsController do

  #Delete these examples and add some real ones
  it "should use DesignsController" do
    controller.should be_an_instance_of(DesignsController)
  end


  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end
end
