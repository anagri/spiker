require File.dirname(__FILE__) + '/spec_helper'

describe LinkHelper do
  it 'should not generate back link if on controller page' do
    params[:controller] = 'dashboard'
    helper.back_link.should == ''
  end

  it 'should generate back link as go to manage page if on show/edit/new action' do
    params[:controller] = 'resources'
    helper.stubs(:resources_path).returns('/resources')
    ['show', 'edit', 'new'].each do |action|
      params[:action] = action
      helper.back_link.should == '<a href="/resources">Back</a>'
    end
  end

  it 'should generate back link to dashboard if on resources page' do
    params[:controller] = 'resources'
    params[:action] = 'index'
    helper.back_link.should == '<a href="/dashboard">Back</a>'
  end
end