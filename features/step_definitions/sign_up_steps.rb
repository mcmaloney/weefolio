Given /^there are no users$/ do
  User.delete_all
end

Given /^there are no objects associated with users$/ do
  Design.delete_all
  Plan.delete_all
  Portfolio.delete_all
end

Given /^there is a user with login "([^\"]*)" and email "([^\"]*)"$/ do |login, email|
  user = Factory(:user, :login => login, :email => email)
  user.setup
end

Given /^I sign up with "([^\"]*)", "([^\"]*)", "([^\"]*)"$/ do |login, email, password|
  When %{I fill in "user_login" with "#{login}"}
  When %{I fill in "user_email" with "#{email}"}
  When %{I fill in "user_password" with "#{password}"}
  When %{I fill in "user_password_confirmation" with "#{password}"}
  When %{I press "Sign up"}
end

Then /^I should have a portfolio$/ do
  user = User.find_by_login("mcmaloney")
  user.portfolio.user_id.should == user.id
end

Then /^I should have a design$/ do
  user = User.find_by_login("mcmaloney")
  user.design.user_id.should == user.id
end

Then /^I should have a plan$/ do
  user = User.find_by_login("mcmaloney")
  user.plan.user_id.should == user.id
  user.plan.level.should == 1
end

Then /^there should be ([0-9]*) user$/ do |count|
  User.count.should == count.to_i
end

Then /^there should be ([0-9]*) plan$/ do |count|
  Plan.count.should == count.to_i
end

Then /^there should be ([0-9]*) portfolio$/ do |count|
  Portfolio.count.should == count.to_i
end

Then /^there should be ([0-9]*) design$/ do |count|
  Design.count.should == count.to_i
end

