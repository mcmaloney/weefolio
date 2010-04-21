Factory.define :user do |u|
  u.sequence(:login) { |l| "user#{l}" }
  u.sequence(:email) { |e| "you#{e}@yours.com" }
  u.password "giraffe"
  u.password_confirmation { |c| c.password }
  u.design_type 1
end

Factory.define :design do |d|
  d.user_id 1
end

Factory.define :piece do |p|
  p.title Faker::Lorem.sentence
end

# Using card number/CVV here but NEITHER OF THEM IS BEING STORED IN THE DATABASE FOR PCI COMPLIANCE.
Factory.define :plan do |p|
  p.card_number "4007000000027"
  p.card_verification "123"
  p.card_expiration_month "4"
  p.card_expiration_year "2012"
  p.card_type "Visa"
  p.billing_first_name Faker::Name.first_name
  p.billing_last_name Faker::Name.last_name
  p.billing_address Faker::Address.street_address
  p.billing_city Faker::Address.city
  p.billing_state Faker::Address.us_state
  p.billing_postal_code Faker::Address.zip_code
end