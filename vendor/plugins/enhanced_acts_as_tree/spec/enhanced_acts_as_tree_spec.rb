require File.dirname(__FILE__) + '/spec_helper'

class TestClass;
end

describe EnhancedActsAsTree do
  before(:each) do
    TestClass.class_eval {include EnhancedActsAsTree}
  end

  it 'should include enhanced acts as tree' do
    TestClass.should be_respond_to(:enhanced_acts_as_tree)
  end

  it 'should call acts as tree' do
    TestClass.expects(:acts_as_tree).once
    TestClass.class_eval { enhanced_acts_as_tree }
  end

  describe 'behavior' do
    before(:each) do
      TestClass.stubs(:acts_as_tree)
      TestClass.class_eval { enhanced_acts_as_tree }
    end

    it 'should return false if no root exists' do
      TestClass.expects(:root).once.returns(nil)
      TestClass.should_not be_root
    end

    it 'should return true if root exists' do
      TestClass.expects(:root).once.returns(stub('root'))
      TestClass.should be_root
    end

    it 'should return true if self is root' do
      test = TestClass.new
      test.stubs(:root).returns(test)
      test.should be_root
    end

    it 'should return false if self is not root' do
      test = TestClass.new
      test.stubs(:root).returns(stub('root'))
      test.should_not be_root
    end
  end
end