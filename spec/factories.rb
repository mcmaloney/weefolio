Factory.define :user do |u|
  u.first_name "Michael"
  u.last_name "Maloney"
  u.login "mcmaloney"
  u.email "michael@maloney.com"
  u.password "giraffe"
  u.password_confirmation { |c| c.password }
end