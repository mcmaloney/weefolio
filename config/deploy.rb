require 'mt-capistrano'
 
set :site,         "9705"
set :application,  "weefolio"
set :webpath,      "test.weefolio.com"
set :domain,       "kevinjohngomez.com"
set :user,         "kevinjohngomez.com"
set :password,     "blink182"
 
ssh_options[:username] = 'serveradmin%primarydomain.com'
 
set :repository, "git@github.com:mcmaloney/weefolio.git"
set :deploy_to,  "/home/#{site}/containers/rails/#{application}"
set :scm,        "git"

default_run_options[:pty]   = true
ssh_options[:forward_agent] = true
 
set :checkout, "export"
 
role :web, "#{domain}"
role :app, "#{domain}"
role :db,  "#{domain}", :primary => true
 

    
    
    



