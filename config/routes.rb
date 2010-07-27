ActionController::Routing::Routes.draw do |map|
  map.root :controller => :home

  map.login 'login', :controller => :sessions, :action => :new, :conditions => {:method => :get}
  map.logout 'logout', :controller => :sessions, :action => :destroy
  map.connect 'login', :controller => :sessions, :action => :create, :conditions => {:method => :post}
  map.edit_profile '/edit_profile', :controller => :users, :action => :edit_profile, :conditions => {:method => :get}

  map.filter 'locale'
  map.resources :password_resets, :only => [:new, :create, :edit, :update]

  map.connect 'dashboard/:action', :controller => 'dashboard'
  map.dashboard '/dashboard', :controller => 'dashboard', :action => :index

  map.resources :users, :offices, :office_types, :client_types
  map.resources :additional_attributes, :only => [:index, :new, :create, :show]
  map.connect 'offices/:id/attributes', :controller => :offices, :action => :attributes

  # temporary paths
  map.clients '/clients', :controller => :dashboard
  map.products '/products', :controller => :dashboard
  map.reports '/reports', :controller => :dashboard
  map.accounts '/accounts', :controller => :dashboard
  map.system '/system', :controller => :dashboard
end
