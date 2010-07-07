require File.dirname(__FILE__) + '/spec_helper'

describe TreeHelper do
  it 'should generate tree' do
    sub_child = stub('sub child', :name => 'sub child', :id=> 3, :children => [], :class => Office)
    child = stub('child', :name => 'child', :id=> 2, :children => [sub_child], :class => Office)
    head = stub('head', :name => 'head', :id=> 1, :children => [child], :class => Office)
    helper.tree(head).should == <<-EXPECTED
<ul>
<li><span id="Office-1"><a href="/offices/1">head</a></span>
<ul>
<li><span id="Office-2"><a href="/offices/2">child</a></span>
<ul>
<li><span id="Office-3"><a href="/offices/3">sub child</a></span>
</li>
</ul>
</li>
</ul>
</li>
</ul>
EXPECTED
  end
end