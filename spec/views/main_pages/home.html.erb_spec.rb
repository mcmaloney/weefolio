require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/main_pages/home" do
  before(:each) do
    render 'main_pages/home'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/main_pages/home])
  end
end
