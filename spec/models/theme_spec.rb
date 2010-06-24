require 'spec_helper'

describe Theme do
  it "should show the pathname" do
    theme = Factory(:theme)
    theme.pathname.should == "public/themes/#{theme.directory_name}/#{theme.template_filename}"
  end
  
  it "should show if we have connected the attributes of the model with the file names in the filesystem" do
    theme = Factory(:theme)
    theme.connected?.should be_true
  end
  
  it "should show if we have not connected to the filesystem correctly" do
    bogus_theme = Factory(:theme, :directory_name => "dne", :template_filename => "dne-template.html")
    bogus_theme.connected?.should be_false
  end
  
  it "should render a preview of itself" do
    theme = Factory(:theme)
    theme.render_preview.should include("<%=")
  end
end
