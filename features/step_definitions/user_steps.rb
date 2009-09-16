Given /^there are no users$/ do
  User.delete_all
end

When /^I sign up as "([^\"]*)"$/ do |login|
  When %{I fill in "user_login" with "#{login}"}
  When %{I fill in "Email" with "michael@maloney.com"}
  When %{I fill in "Password" with "giraffe"}
  When %{I fill in "user_password_confirmation" with "giraffe"}
  When %{I check "user_has_read_terms"}
  When %{I press "Sign Up"}
end

Then /^I should have ([0-9]*) user$/ do |count|
  User.count.should == count.to_i
end

Then /^I should have ([0-9]*) portfolio$/ do |count|
  Portfolio.count.should == count.to_i
end

Then /^I should have ([0-9]*) design$/ do |count|
  Design.count.should == count.to_i
end

Given /^the following users exist:$/ do |table|
  table.hashes.each do |hash|
    Factory(:user, hash)
  end
end

Given /^I have already signed up as "([^\"]*)"$/ do |login|
  @login_user = Factory(:user, :first_name => "Kevin", :last_name => "Gomez", :login => login, :has_read_terms => true)
  @login_user.setup_portfolio_and_design
  @login_user.activate!
end

When /^I login as "([^\"]*)"$/ do |login|
  When %{I fill in "login" with "#{login}"}
  When %{I fill in "password" with "#{@login_user.password}"}
  When %{I press "Login"}
end

Given /^I am logged in as "([^\"]*)"$/ do |login|
  @user = Factory(:user, :first_name => "Michael", :last_name => "Michael", :login => login, :has_read_terms => true, :password => "giraffe")
  @user.setup_portfolio_and_design
  @user.activate!
  visit login_path
  When %{I fill in "login" with "#{login}"}
  When %{I fill in "password" with "#{@user.password}"}
  When %{I press "Login"}
end

Given /^I have additional info that is blank$/ do
  @user.has_blank_info
end

Given /^I update my about me to say "([^\"]*)"$/ do |about_me|
  When %{I fill in "About Me" with "#{about_me}"}
end

Given /^I update my tag line to say "([^\"]*)"$/ do |tag_line|
  When %{I fill in "user_tag_line" with "#{tag_line}"}
end

Then /^I should see the logged in nav bar in all its glory$/ do
  Then %{I should see "Portfolio"}
  Then %{I should see "Design"}
  Then %{I should see "Account"}
  Then %{I should see "My Weefolio"}
end

Given /^there is a user named "([^\"]*)"$/ do |login|
  Factory(:user, :login => login)
end

Then /^I should have no users$/ do
  User.count.should == 0
end

#### RESET PASSWORD ####

Given /^I change my password to "([^\"]*)"$/ do |password|
  When %{I fill in "login" with "#{@login_user.login}"}
  When %{I fill in "email" with "#{@login_user.email}"}
  When %{I fill in "new password" with "#{password}"}
  When %{I fill in "new password confirm" with "#{password}"}
  When %{I press "Reset Password"}
end

Given /^I enter bad info for changing my password to "([^\"]*)"$/ do |password|
  When %{I fill in "login" with "mcmaloney"}
  When %{I fill in "email" with "#{@login_user.email}"}
  When %{I fill in "new password" with "#{password}"}
  When %{I fill in "new password confirm" with "#{password}"}
  When %{I press "Reset Password"}
end

#### PAYMENT STUFF ####

Given /^I enter my credit card information in the given fields$/ do
  When %{I select "Visa" from "user_card_type"}
  When %{I fill in "user_card_number" with "1234567812345678"}
  When %{I fill in "user_card_verification" with "123"}
  When %{I select "6" from "user_card_expiration_month_2i"}
  When %{I select "2011" from "user_card_expiration_year_1i"}
end


#### ADMIN ####

Given /^I am an admin user$/ do
  @admin_user = Factory(:user, :login => "admin", :admin_user => true)
  @admin_user.setup_portfolio_and_design
  @admin_user.activate!
end

Given /^I login$/ do
  visit login_path
  When %{I fill in "login" with "#{@admin_user.login}"}
  When %{I fill in "password" with "#{@admin_user.password}"}
  When %{I press "Login"}
end







