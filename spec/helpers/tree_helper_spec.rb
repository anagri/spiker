require File.dirname(__FILE__) + '/spec_helper'

describe TreeHelper do
  it 'should generate tree' do
    sub_child = stub('sub child', :name => 'sub child', :children => [])
    child = stub('child', :name => 'child', :children => [sub_child])
    head = stub('head', :name => 'head', :children => [child])
    helper.tree(head).should == "head<br/>&gt;child<br/>&gt;&gt;sub child<br/>"
  end
end