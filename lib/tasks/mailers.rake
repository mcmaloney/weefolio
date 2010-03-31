namespace :mailers do
  desc "send a test email"
  task :test => :environment do
    user = User.find_by_login("mcmaloney")
    UserMailer.deliver_delete_account_message(user)
  end
end