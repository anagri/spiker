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
end

describe 'Resources Routes' do
  it 'should map users resource' do
    {:get => '/users/new'}.should route_to(:controller => 'users', :action => 'new')
    {:post => '/users'}.should route_to(:controller => 'users', :action => 'create')
  end
end

describe 'Named Routes' do
  describe 'Session' do
    it 'should generate login_path' do
      login_path.should == '/login'
    end

    it 'should generate logout_path' do
      logout_path.should == '/logout'
    end

  end

  describe 'Users' do
    it 'should generate user resources routes' do
      assert_restful_routing("user")
    end
  end
end