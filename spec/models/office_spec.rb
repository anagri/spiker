require File.dirname(__FILE__) + '/spec_helper'

describe Office do
  before(:each) do
    @office_type = Factory._create(:office_type)
    @sub_office_type = Factory._create(:office_type, :parent => @office_type)
    @branch_office_type = Factory._create(:office_type, :parent => @sub_office_type)
    @head_office = Factory._create(:office, :name => "head office", :office_type => @office_type)
    @sub_office = Factory._create(:office, :parent => @head_office, :name => "sub office")
    @branch_office = Factory._create(:office, :parent => @sub_office, :name => "branch office")
  end

  it 'should give list of available office for a given user' do
    @head_office.self_and_children(true).should == [@branch_office, @head_office, @sub_office]
    @sub_office.self_and_children(true).should == [@branch_office, @sub_office]
    @branch_office.self_and_children(true).should == [@branch_office]
  end

  describe 'invalid office' do
    it 'should fail validation if parent office not present' do
      invalid_office = Office.new(:name => 'some office', :office_type => @office_type)
      invalid_office.should have_ar_errors(:parent => :blank)
    end

    it 'should fail validation if office type not child of parent office type' do
      invalid_office = Office.new(:name => 'some office', :parent => @head_office)
      invalid_office.office_type = @office_type
      invalid_office.should have_ar_errors(:office_type => :office_type_invalid)
    end
  end

  it 'should get offices for select option' do
    Office.html_options.should == [[@branch_office.name, @branch_office.id], [@head_office.name, @head_office.id], [@sub_office.name, @sub_office.id]]
  end

  describe 'enhanced acts as tree' do
    it 'should get all ancestors excluding self' do
      @branch_office.ancestors.should == [@head_office, @sub_office]
      @sub_office.ancestors.should == [@head_office]
      @head_office.ancestors.should == []
    end

    it 'should get all ancestors including self' do
      @branch_office.ancestors_including_self.should == [@head_office, @sub_office, @branch_office]
      @sub_office.ancestors_including_self.should == [@head_office, @sub_office]
      @head_office.ancestors_including_self.should == [@head_office]
    end
  end

  describe 'validates name' do
    before(:each) do
      @resource = Office.new(:parent => @head_office)
    end

    it_should_behave_like 'validates name'
  end

  describe 'autosetting of office type' do
    it 'should autoset office type based on parent if parent set through accessor' do
      office = Office.new
      office.parent = @head_office
      assert_office_type_set(office)
    end

    it 'should autoset office type based on parent if parent set through initialize' do
      office = Office.new(:parent => @head_office)
      assert_office_type_set(office)
    end

    it 'should autoset office type based on parent if parent set through attribute' do
      office = Office.new(:name => 'office unique name')
      office.without_access_control_do_update_attribute(:parent, @head_office)
      assert_office_type_set(office)
    end

    it 'should autoset office type based on parent if parent set through accessor' do
      office = Office.new
      office.parent_id = @head_office.id
      assert_office_type_set(office)
    end

    it 'should autoset office type based on parent if parent set through initialize' do
      office = Office.new(:parent_id => @head_office.id)
      assert_office_type_set(office)
    end

    it 'should autoset office type based on parent id if parent id set through attribute' do
      office = Office.new(:name => 'office unique name')
      office.without_access_control_do_update_attribute(:parent_id, @head_office.id)
      assert_office_type_set(office)
    end

    def assert_office_type_set(office)
      office.parent_id.should == @head_office.id
      office.office_type.should == @sub_office_type
      office.office_type_id.should == @sub_office_type.id
    end
  end

  describe 'html options for parent' do
    it 'should return all offices under except offices whose office type has no child' do
      @head_office.html_options_for_parent.should == [[@head_office.name, @head_office.id], [@sub_office.name, @sub_office.id]]
      @sub_office.html_options_for_parent.should == [[@sub_office.name, @sub_office.id]]
      @branch_office.html_options_for_parent.should == []
    end
  end
end