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

    it 'should return leaf node' do
      head_office_type = Factory.without_access_control_do_create(:office_type)
      branch_office_type = Factory.without_access_control_do_create(:office_type, :parent_id => head_office_type.id)
      OfficeType.leaf.should == branch_office_type
    end

    it 'should not add node if causes circular hierarchy' do
      head_office_type = Factory.without_access_control_do_create(:office_type)
      branch_office_type = Factory.without_access_control_do_create(:office_type, :parent_id => head_office_type.id)
      leaf_office_type = Factory.without_access_control_do_create(:office_type, :parent_id => branch_office_type.id)
      head_office_type.parent = leaf_office_type
      head_office_type.save
      assert_invalid_record(head_office_type, :parent => :circular_hierarchy)
    end
  end
end