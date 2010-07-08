require File.dirname(__FILE__) + '/spec_helper'

class StubController < ApplicationController
end

describe 'ApplicationController', :type => :controller do
  controller_name :stub

  describe 'Retricted Actions' do
    before(:each) do
      StubController.class_eval do
        filter_access_to :restricted_action

        def restricted_action
        end
      end

      ActionController::Routing::Routes.draw do |map|
        map.connect 'restricted', :controller => :stub, :action => 'restricted_action'
      end
    end

    it 'should render unauthorized page if permission denied' do
      get :restricted_action
      response.should be_unauthorized
      response.should render_template('unauthorized')
    end
  end

  describe 'support xhr' do
    before(:each) do
      @office_type = Factory._create(:office_type)
      @resource = Factory._create(:office, :office_type => @office_type)
      StubController.class_eval do
        before_filter :support_xhr, :only => [:create, :index]
        @@resource = nil
        def create
          redirect_to @@resource
        end

        def index
        end
      end
      StubController.send(:class_variable_set, :@@resource, @resource)

      ActionController::Routing::Routes.draw do |map|
        map.connect 'create', :controller => :stub, :action => 'create'
        map.connect 'index', :controller => :stub, :action => 'index'
      end
    end

    it 'should send head created if redirect_to called' do
      xhr :get, :create
      response.code.should == '201'
      response.location.should == "http://test.host/offices/#{@resource.id}"
    end

    it 'should render without layout if render called' do
      xhr :get, :index
      response.code.should == '200'
      response.should render_template('index')
      response.should_not render_template('layouts/application')
    end
  end
end