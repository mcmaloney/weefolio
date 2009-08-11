Factory.define :user do |u|
  u.first_name "Michael"
  u.last_name "Maloney"
  u.login "mcmaloney"
  u.sequence(:email) { |e| "michael#{e}@maloney.com" } 
  u.password "giraffe"
  u.password_confirmation { |c| c.password }
  u.design_type 1
  u.account_tier 1
  u.has_read_terms false
end

Factory.define :piece do |p|
  p.title "My Awesome Art"
  p.description "This is so awesome it's gonna make your eyes bleed."
  p.price 12.75
  p.for_sale false
end

Factory.define :post do |p|
  p.title "My New Post"
  p.body "Here is a new post I wrote for the Weefolio community to look at."
  p.author "kjgomez"
end