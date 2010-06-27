require File.dirname(__FILE__) + '/spec_helper'

describe 'Resources Routes' do
  before(:all) do
    deactivate_routing_filter
  end

  it 'should map users resource' do
    {:get => '/users/new'}.should route_to(:controller => 'users', :action => 'new')
    {:post => '/users'}.should route_to(:controller => 'users', :action => 'create')
  end
end
