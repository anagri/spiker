require File.dirname(__FILE__) + '/spec_helper'

describe Office do
  before(:each) do
    @office_type = Factory.without_access_control_do_create(:office_type)
    @head_office = Factory.without_access_control_do_create(:office, :name => "head office")
    @sub_office = Factory.without_access_control_do_create(:office, :parent => @head_office, :name => "sub office")
    @branch_office = Factory.without_access_control_do_create(:office, :parent => @sub_office, :name => "branch office")
  end

  it 'should give list of available office for a given user' do
    @head_office.self_and_children(true).should == [@branch_office, @head_office, @sub_office]
    @sub_office.self_and_children(true).should == [@branch_office, @sub_office]
    @branch_office.self_and_children(true).should == [@branch_office]
  end

  describe 'invalid office' do
    it 'should fail validation if name not provided' do
      invalid_office = Office.without_access_control_do_create(:name => nil, :parent => @head_office, :office_type => @office_type)
      invalid_office.should have_ar_errors(:name => :blank)
    end

    it 'should fail validation if name is blank' do
      invalid_office = Office.without_access_control_do_create(:name => '', :parent => @head_office, :office_type => @office_type)
      invalid_office.should have_ar_errors(:name => :blank)
    end

    it 'should fail validation if name is not unique' do
      existing_office = Office.without_access_control_do_create(:name => 'already present', :parent => @head_office, :office_type => @office_type)
      invalid_office = Office.without_access_control_do_create(:name => existing_office.name, :parent => @head_office, :office_type => @office_type)
      invalid_office.should have_ar_errors(:name => :taken)
    end

    it 'should fail validation if name is very long' do
      invalid_office = Office.without_access_control_do_create(:name => 'a'*31, :parent => @head_office, :office_type => @office_type)
      invalid_office.should have_ar_errors(:name => :too_long)
    end

    it 'should pass validation if name is under limit' do
      invalid_office = Office.without_access_control_do_create(:name => 'a'*30, :parent => @head_office, :office_type => @office_type)
      invalid_office.should be_valid
    end

    it 'should fail validation if parent office not present' do
      invalid_office = Office.without_access_control_do_create(:name => 'some office', :office_type => @office_type)
      invalid_office.should have_ar_errors(:parent => :blank)
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
      @resource = Office.new(:parent => @branch_office,:office_type => @office_type)
    end
    
    it_should_behave_like 'validates name'
  end
end