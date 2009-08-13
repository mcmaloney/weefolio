Given /^I send myself a message$/ do
  When %{I fill in "name" with "Michael"}
  When %{I fill in "from" with "mcm@crushlovely.com"}
  When %{I fill in "message" with "Hey there, good lookin'!"}
  When %{I press "Send Message"}
end

Given /^I send weefolio a message of praise and admiration$/ do
  When %{I fill in "subject" with "Undying Love"}
  When %{I fill in "message" with "Weefolio has changed my life."}
  When %{I press "Send Message"}
end

Given /^I have forgotten my password$/ do
  @forgot_user = Factory(:user, :login => "mcmaloney", :email => "maloney.mc@gmail.com")
end

When /^I fill in the account details I do remember$/ do
  When %{I fill in "login" with "mcmaloney"}
  When %{I fill in "email" with "maloney.mc@gmail.com"}
  When %{I fill in "new password" with "giraffe"}
  When %{I fill in "new password confirm" with "giraffe"}
  When %{I press "Change my Password"}
end

Given /^I fill in incorrect details$/ do
  When %{I fill in "login" with "mcmaloney"}
  When %{I fill in "email" with "hacker@incorrect.com"}
  When %{I fill in "new password" with "giraffe"}
  When %{I fill in "new password confirm" with "giraffe"}
  When %{I press "Change my Password"}
end
