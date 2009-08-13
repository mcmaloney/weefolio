Given /^the following blog posts exist:$/ do |table|
  table.hashes.each do |hash|
    Factory(:post, hash)
  end
end

Given /^there is a blog post called "([^\"]*)"$/ do |title|
  Factory(:post, :title => title, :body => "Because they are horrible creatures.")
end

Given /^there are no blog posts$/ do
  Post.delete_all
end

Given /^I create a post called "([^\"]*)"$/ do |title|
  When %{I fill in "Title" with "#{title}"}
  When %{I fill in "Body" with "This is really too much, guys. Even for me."}
  When %{I press "Publish"}
end

Then /^I should have ([0-9]*) post$/ do |count|
  Post.count.should == count.to_i
end

When /^I change the title of the post to "([^\"]*)"$/ do |title|
  When %{I fill in "Title" with "#{title}"}
  When %{I press "Save"}
end

Given /^there is a post called "([^\"]*)"$/ do |title|
  Factory(:post, :title => title)
end

Then /^there should be no posts$/ do
  Post.count.should == 0
end

Given /^the following posts exist:$/ do |table|
  table.hashes.each do |hash|
    Factory(:post, hash)
  end
end



