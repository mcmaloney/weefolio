password = "w33folio"

User.seed(:email) do |u|
  u.email = "maloney.mc@gmail.com"
  u.login = "michaelmaloney"
  u.password = password
  u.password_confirmation = password
  u.admin_user = true
end

User.seed(:email) do |u|
  u.email = "hello@kevinjohngomez.com"
  u.login = "kgomez"
  u.password = password
  u.password_confirmation = password
  u.admin_user = true
end

