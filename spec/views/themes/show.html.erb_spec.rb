require 'spec_helper'

describe "/themes/show" do
  before(:each) do
    render 'themes/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/themes/show])
  end
end
