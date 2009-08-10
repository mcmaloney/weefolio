Given /^I add a piece called "([^\"]*)"$/ do |title|
  When %{I fill in "Title" with "#{title}"}
  When %{I fill in "Description" with "This is going to be bad."}
  When %{I attach the file at "/Users/Maloney/desktop/weefolio/public/images/test_images/janus.jpg" to "piece_image_1"}
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
  @user.change_tier(level.to_i)
  @user.save
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

Given /^I add a piece that I want to sell called "([^\"]*)"$/ do |title|
  When %{I fill in "Title" with "#{title}"}
  When %{I fill in "Description" with "A hooker floating in the Sienne at dawn."}
  When %{I attach the file at "/Users/Maloney/desktop/weefolio/public/images/test_images/janus.jpg" to "piece_image_1"}
  When %{I check "For Sale"}
  When %{I fill in "piece_price" with "150000.46"}
  When %{I press "Create"}
end

Then /^I should have ([0-9]*) piece in my portfolio$/ do |count|
  @user.portfolio.pieces.count.should == count.to_i
end

###### WEEFOLIO STEPS ######
Given /^my layout type is ([0-9]*)$/ do |number|
  @user.design.set_layout_type(number.to_i)
  @user.design.save
end

Then /^its layout type should be "([^\"]*)"$/ do |type|
  @user.design.render_layout_type.should == type
end

Given /^I have uploaded a piece called "([^\"]*)" to my portfolio$/ do |title|
  visit new_portfolio_piece_path(@user.portfolio)
  When %{I fill in "Title" with "#{title}"}
  When %{I fill in "Description" with "Some shit I did a while back."}
  When %{I attach the file at "/Users/Maloney/desktop/weefolio/public/images/test_images/janus.jpg" to "piece_image_1"}
  When %{I press "Create"}
end


