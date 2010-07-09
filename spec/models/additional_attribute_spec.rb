require File.dirname(__FILE__) + '/spec_helper'

describe AdditionalAttribute do
  describe 'invalid additional attribute' do
    it 'should validate resource type' do
      StringAttribute.new(:name => 'valid_name', :resource_type => 'InvalidResource', :length => 30).should have_ar_errors(:resource_type => :inclusion)

      ['User', 'Office'].each do |resource_type|
        StringAttribute.new(:name => 'valid_name', :resource_type => resource_type, :length => 30).should be_valid
      end
    end

    it 'should validate for field types' do
      AdditionalAttribute.field_types.each do |field_type|
        field_type.new(:name => 'valid_name', :resource_type => 'Office', :length => 30, :precision => 2).should be_valid
      end
    end

    it 'should validate length' do
      [DecimalAttribute, IntegerAttribute, StringAttribute].each do |field_type|
        field_type.new(:name => "#{field_type.display_name}_valid_name", :resource_type => 'Office', :precision => 2).should have_ar_errors(:length => :blank)
      end
    end

    describe 'name validation' do
      before(:each) do
        @resource = StringAttribute.new(:resource_type => 'User', :length => 30)
      end

      it_should_behave_like 'validates name'
    end

    it 'should validate if column already exists in resource' do
      invalid_attribute = StringAttribute.new(:name => 'username', :resource_type => 'User', :length => 30)
      invalid_attribute.should have_ar_errors(:name => :taken)
    end
  end

  describe 'autocreate columns' do
    before(:each) do
      activate_authlogic
    end

    it 'should create column when attribute is saved' do
      AdditionalAttribute.field_types.each do |field_type|
        AdditionalAttribute.resource_types.each do |resource_type|
          Authorization::Maintenance.without_access_control do
            column_name = "#{resource_type}_#{field_type.display_name}".downcase
            field_type.create!(:name => column_name, :resource_type => resource_type.name, :length => 30, :precision => 2)
            column_information = resource_type.columns_hash[column_name]
            column_information.should_not be_nil
          end
        end
      end
    end
  end
end