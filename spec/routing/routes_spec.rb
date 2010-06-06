require 'spec_helper'

describe "Routes" do
  it 'should map the root to home' do
    params_from(:get, '/').should == {:controller => "home", :action => "index"}
  end
end