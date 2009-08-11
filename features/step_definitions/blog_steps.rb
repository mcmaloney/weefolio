Given /^the following blog posts exist:$/ do |table|
  table.hashes.each do |hash|
    Factory(:post, hash)
  end
end

Given /^there is a blog post called "([^\"]*)"$/ do |title|
  Factory(:post, :title => title, :body => "Because they are horrible creatures.")
end
