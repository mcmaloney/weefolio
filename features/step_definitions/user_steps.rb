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

