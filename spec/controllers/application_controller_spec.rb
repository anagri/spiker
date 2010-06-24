require File.dirname(__FILE__) + '/spec_helper'

class StubController < ApplicationController
end

describe 'ApplicationController', :type => :controller do
  controller_name :stub

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