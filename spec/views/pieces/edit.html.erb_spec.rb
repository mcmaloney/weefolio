require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pieces/edit" do
  before(:each) do
    render 'pieces/edit'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/pieces/edit])
  end
end
