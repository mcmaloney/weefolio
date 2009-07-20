Given /^there are no users$/ do
  User.delete_all
end

When /^I sign up as "([^\"]*)"$/ do |login|
  When %{I fill in "First Name" with "Michael"}
  When %{I fill in "Last Name" with "Maloney"}
  When %{I fill in "Login" with "#{login}"}
  When %{I fill in "Email" with "michael@maloney.com"}
  When %{I fill in "Password" with "giraffe"}
  When %{I fill in "Password Confirmation" with "giraffe"}
  When %{I press "Sign Up"}
end

Then /^I should have ([0-9]*) user$/ do |count|
  User.count.should == count.to_i
end

Then /^I should have ([0-9]*) portfolio$/ do |count|
  Portfolio.count.should == count.to_i
end

Given /^I have already signed up as "([^\"]*)"$/ do |login|
  @login_user = Factory(:user, :first_name => "Kevin", :last_name => "Gomez", :login => login)
  @login_user.make_portfolio
  @login_user.activate!
end

When /^I login as "([^\"]*)"$/ do |login|
  When %{I fill in "Login" with "#{login}"}
  When %{I fill in "Password" with "#{@login_user.password}"}
  When %{I press "Login"}
end

Given /^I am logged in as "([^\"]*)"$/ do |login|
  @user = Factory(:user, :first_name => "Michael", :last_name => "Michael", :login => login)
  @user.make_portfolio
  @user.activate!
  visit login_path
  When %{I fill in "Login" with "#{login}"}
  When %{I fill in "Password" with "#{@user.password}"}
  When %{I press "Login"}
end

Given /^I have additional info that is blank$/ do
  @user.has_blank_info
end

Given /^I update my about me to say "([^\"]*)"$/ do |about_me|
  When %{I fill in "About Me" with "#{about_me}"}
end

Given /^I update my tag line to say "([^\"]*)"$/ do |tag_line|
  When %{I fill in "Tag Line" with "#{tag_line}"}
end




