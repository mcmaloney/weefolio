require 'mt-capistrano'
 
set :site,         "9705"
set :application,  "weefolio_test"
set :webpath,      "test.weefolio.com"
set :domain,       "kevinjohngomez.com"
set :user,         "kevinjohngomez.com"
set :password,     "blink182"
 
ssh_options[:username] = 'kevinjohngomez.com'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :repository, "git@github.com:mcmaloney/weefolio.git"
set :branch, "master"
set :scm, "git"
set :deploy_to,  "/home/#{site}/containers/rails/#{application}"
 
role :web, "#{domain}"
role :app, "#{domain}"
role :db,  "#{domain}", :primary => true
 
task :after_update_code, :roles => :app do
  put(File.read('config/database.yml'), "#{release_path}/config/database.yml", :mode => 0444)
end
 
task :restart, :roles => :app do
  run "mtr generate_htaccess #{application}"
  run "mtr create_link #{application}"
  migrate
end
