Factory.define :user do |u|
  u.first_name "Michael"
  u.last_name "Maloney"
  u.login "mcmaloney"
  u.email "michael@maloney.com"
  u.password "giraffe"
  u.password_confirmation { |c| c.password }
  u.account_tier 1
  u.layout_type 1
end

Factory.define :piece do |p|
  p.title "My Awesome Art"
  p.description "This is so awesome it's gonna make your eyes bleed."
  p.price 12.75
  p.for_sale false
end
  