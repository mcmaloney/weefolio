Factory.define :user do |u|
  u.sequence(:login) { |l| "user#{l}" }
  u.sequence(:email) { |e| "you#{e}@yours.com" }
  u.password "giraffe"
  u.password_confirmation { |c| c.password }
end

Factory.define :design do |d|
  d.user_id 1
end