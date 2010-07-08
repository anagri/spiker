require File.dirname(__FILE__) + '/spec_helper'

describe OfficeType do
  describe 'acts as hierarchy' do
    it 'should return root node' do
      office_type = Factory.without_access_control_do_create(:office_type)
      office_type.should == OfficeType.root
    end

    it 'should return true if root exists' do
      Factory.without_access_control_do_create(:office_type)
      OfficeType.root?.should == true
    end

    it 'should return false if root does not exist' do
      OfficeType.root?.should == false
    end

    describe 'hierarchy test' do
      before(:each) do
        @head_office_type = Factory.without_access_control_do_create(:office_type)
        @branch_office_type = Factory.without_access_control_do_create(:office_type, :parent_id => @head_office_type.id)
        @leaf_office_type = Factory.without_access_control_do_create(:office_type, :parent_id => @branch_office_type.id)
      end

      it 'should return leaf node' do
        OfficeType.leaf.should == @leaf_office_type
      end

      it 'should not add node if causes circular hierarchy' do
        @head_office_type.parent = @leaf_office_type
        @head_office_type.save
        @head_office_type.should have_ar_errors(:parent => :circular_hierarchy)
      end

      it 'should get all ancestors including self' do
        @leaf_office_type.ancestors.should == [@head_office_type, @branch_office_type]
        @branch_office_type.ancestors.should == [@head_office_type]
        @head_office_type.ancestors.should == []
      end

      it 'should get all ancestors excluding self' do
        @leaf_office_type.ancestors_including_self.should == [@head_office_type, @branch_office_type, @leaf_office_type]
        @branch_office_type.ancestors_including_self.should == [@head_office_type, @branch_office_type]
        @head_office_type.ancestors_including_self.should == [@head_office_type]
      end
    end
  end

  describe 'name validation' do
    before(:each) do
      office_type = Factory.without_access_control_do_create(:office_type)
      @resource = OfficeType.new(:parent => office_type)
    end

    it_should_behave_like 'validates name'
  end
end