ActionController::Routing::Routes.draw do |map|
  map.root :controller => :home

  map.login 'login', :controller => :sessions, :action => :new, :conditions => {:method => :get}
  map.logout 'logout', :controller => :sessions, :action => :destroy
  map.connect 'login', :controller => :sessions, :action => :create, :conditions => {:method => :post}

  map.resources :users, :only => [:new, :create, :edit, :update, :show]
end
