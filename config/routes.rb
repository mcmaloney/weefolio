ActionController::Routing::Routes.draw do |map|
  # USER SYSTEM ROUTES
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  # GLOBAL NAV ROUTES
  map.contact '/contact_us', :controller => 'main_pages', :action => 'contact'
  map.directory '/directory', :controller => 'users', :action => 'index'
  map.help '/help', :controller => 'main_pages', :action => 'help'
  map.privacy_policy '/privacy_policy', :controller => 'main_pages', :action => 'privacy_policy'
  map.terms_of_use '/terms_of_use', :controller => 'main_pages', :action => 'terms_of_use'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'reset_password'
  
  # ADMIN ROUTES
  map.users_admin '/users_admin', :controller => 'users', :action => 'users_admin'
  map.pieces_admin '/pieces_admin', :controller => 'pieces', :action => 'pieces_admin'
  
  # USERS
  map.resources :users do |users|
    users.resources :portfolios, :member => { :send_message => :post }
    users.resources :designs
  end
  
  # PORTFOLIOS
  map.resources :portfolios do |portfolios|
    portfolios.resources :pieces
  end
  
  # BLOG
  map.resources :posts
  
  # SEPARATE PIECE ROUTE FOR ADMIN ACTIONS
  map.resources :pieces
  map.resource :session
  
  # ROOT
  map.root :controller => "main_pages", :action => "home"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
