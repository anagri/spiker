ActionController::Routing::Routes.draw do |map|
  map.root :controller => :home

  map.login 'login', :controller => :sessions, :action => :new, :conditions => {:method => :get}
  map.logout 'logout', :controller => :sessions, :action => :destroy
  map.connect 'login', :controller => :sessions, :action => :create, :conditions => {:method => :post}

  map.filter 'locale'
  map.resources :password_resets, :only => [:new, :create, :edit, :update]
  map.dashboard '/dashboard', :controller => 'dashboard'
  map.resources :users, :offices, :office_types, :client_types
end
