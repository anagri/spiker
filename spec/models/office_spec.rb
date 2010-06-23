require File.dirname(__FILE__) + '/spec_helper'

describe Office do
  before(:each) do
    Authorization.ignore_access_control(true)
    @office_type = Factory.create(:office_type)
    @head_office = Factory.create(:office, :name => "head office")
    @sub_office = Factory.create(:office, :parent => @head_office, :name => "sub office")
    @branch_office = Factory.create(:office, :parent => @sub_office, :name => "branch office")
  end

  it 'should give list of available office for a given user' do
    @head_office.self_and_children(true).should == [@branch_office, @head_office, @sub_office]
    @sub_office.self_and_children(true).should == [@branch_office, @sub_office]
    @branch_office.self_and_children(true).should == [@branch_office]
  end

  describe 'invalid office' do
    it 'should fail validation if name not provided' do
      invalid_office = Office.create(:name => nil, :parent => @head_office, :office_type => @office_type)
      assert_invalid_record(invalid_office, :name => :blank)
    end

    it 'should fail validation if name is blank' do
      invalid_office = Office.create(:name => '', :parent => @head_office, :office_type => @office_type)
      assert_invalid_record(invalid_office, :name => :blank)
    end

    it 'should fail validation if name is not unique' do
      existing_office = Office.create(:name => 'already present', :parent => @head_office, :office_type => @office_type)
      invalid_office = Office.create(:name => existing_office.name, :parent => @head_office, :office_type => @office_type)
      assert_invalid_record(invalid_office, :name => :taken)
    end

    it 'should fail validation if name is very long' do
      invalid_office = Office.create(:name => 'a'*31, :parent => @head_office, :office_type => @office_type)
      assert_invalid_record(invalid_office, :name => :too_long)
    end

    it 'should pass validation if name is under limit' do
      invalid_office = Office.create(:name => 'a'*30, :parent => @head_office, :office_type => @office_type)
      invalid_office.should be_valid
    end

    it 'should fail validation if parent office not present' do
      invalid_office = Office.create(:name => 'some office', :office_type => @office_type)
      assert_invalid_record(invalid_office, :parent => :blank)
    end
  end
end