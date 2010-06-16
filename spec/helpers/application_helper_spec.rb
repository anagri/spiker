require File.dirname(__FILE__) + '/spec_helper'

describe ApplicationHelper do
  it 'should return the doctype' do
    helper.doctype.should == '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
         "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
  end

  it 'should return the html tag' do
    helper.html.should == '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">'
  end

  it 'should return end html tag' do
    helper.end_html.should == '</html>'
  end

  describe 't_' do
    it 'should append controller and action' do
      params[:controller] = 'sessions'
      params[:action] = 'index'
      helper.expects(:t).with("sessions.index.key")
      helper.t_(".key")
    end
  end
end
