ActionController::Routing::Routes.draw do |map|
  map.root :controller => :home

  map.login 'login', :controller => :sessions, :action => :new, :conditions => {:method => :get}
  map.logout 'logout', :controller => :sessions, :action => :destroy
  map.connect 'login', :controller => :sessions, :action => :create, :conditions => {:method => :post}
  map.edit_profile '/edit_profile', :controller => :users, :action => :edit_profile, :conditions => {:method => :get}

  map.filter 'locale'
  map.resources :password_resets, :only => [:new, :create, :edit, :update]
  map.dashboard '/dashboard', :controller => 'dashboard'
  map.navigate '/navigate', :controller => 'dashboard', :action => 'navigate', :conditions => {:method => :get}
  map.resources :users, :offices, :office_types, :client_types
  map.resources :additional_attributes, :only => [:index, :new, :create, :show]
  map.offices_configure '/offices/configure', :controller => :offices, :action => :configure
end
