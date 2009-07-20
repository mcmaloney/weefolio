Given /^I add a piece called "([^\"]*)"$/ do |title|
  When %{I fill in "Title" with "#{title}"}
  When %{I fill in "Description" with "This is going to be bad."}
  When %{I press "Create"}
end
