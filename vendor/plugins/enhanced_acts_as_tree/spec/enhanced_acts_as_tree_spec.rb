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

    describe 'self_and_children' do
      before(:each) do
        @test = TestClass.new
        @child_1 = stub('child 1', :id => 1, :name => 'node 1')
        @child_2 = stub('child 2', :id => 3, :name => 'node 3')
        @test.stubs(:children).returns([@child_1, @child_2])
        @test.stubs(:name => 'node 2', :id => 2)
      end

      it 'should return self and childrens in order' do
        @test.self_and_children.should == [@child_1, @test, @child_2]
      end

      it 'should return self and children options' do
        @test.self_and_children_options.should == [['node 1', 1],['node 2', 2],['node 3', 3]]
      end
    end
  end
end