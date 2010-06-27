require File.dirname(__FILE__) + '/spec_helper'

describe 'Mapped Routes' do
  it 'should map / to home' do
    {:get => '/'}.should route_to(:controller => 'home', :action => 'index')
  end

  it 'should map /login to session#new' do
    {:get => '/login'}.should route_to(:controller => 'sessions', :action => 'new')
  end

  it 'should map /logout to session#destroy' do
    {:get => '/logout'}.should route_to(:controller => 'sessions', :action => 'destroy')
  end

  it 'should map /dashboard to dashboard#index' do
    {:get => '/dashboard'}.should route_to(:controller => 'dashboard', :action => 'index')
  end
end
