Given /^I add a piece called "([^\"]*)"$/ do |title|
  When %{I fill in "Title" with "#{title}"}
  When %{I fill in "Description" with "This is going to be bad."}
  When %{I attach the file at "/Users/maloney/Desktop/weefolio/public/images/test_images/janus.jpg" to "Image 1"}
  When %{I press "Create"}
end

Given /^I have ([0-9]*) pieces in my portfolio$/ do |pieces|
  pieces.to_i.times do |piece|
    piece = Factory(:piece)
    @user.portfolio.pieces << piece
  end
end

Given /^I have a piece in my portfolio called "([^\"]*)"$/ do |title|
  piece = Factory(:piece, :title => title)
  @user.portfolio.pieces << piece
end

Given /^my account tier is ([0-30]*)$/ do |level|
  @user.account_tier = level.to_i
end

Given /^I have no pieces in my portfolio$/ do
  Piece.delete_all
end

Given /^I change the info to "([^\"]*)" and "([^\"]*)"$/ do |title, description|
  When %{I fill in "Title" with "#{title}"}
  When %{I fill in "Description" with "#{description}"}
  When %{I press "Update"}
end

Then /^I should have no pieces in my portfolio$/ do 
  @user.portfolio.pieces.count.should == 0
end

