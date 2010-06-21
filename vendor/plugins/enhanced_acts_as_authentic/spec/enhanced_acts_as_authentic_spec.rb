require File.dirname(__FILE__) + '/spec_helper'

describe EnhancedActsAsAuthentic do
  it 'should respond to enhanced_acts_as_authentic method' do
    ActiveRecord::Base.should be_respond_to(:enhanced_acts_as_authentic)
  end

  it 'should call acts as authentic' do
    ActiveRecord::Base.expects(:acts_as_authentic).once
    ActiveRecord::Base.enhanced_acts_as_authentic
  end

  it 'should call method missing' do
    stub_result = stub('result')
    ActiveRecord::Base.expects(:create).once.returns(stub_result)
    ActiveRecord::Base.without_access_control_do_create.should == stub_result
  end
end