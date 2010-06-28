require File.dirname(__FILE__) + '/spec_helper'

describe AdditionalAttribute do
  describe 'invalid office attribute' do
    it 'should validate resource type' do
      AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'InvalidResource', :field_type => 'string', :length => 30).should have_ar_errors(:resource_type => :inclusion)

      ['User', 'Office'].each do |resource_type|
        AdditionalAttribute.new(:name => 'valid_name', :resource_type => resource_type, :field_type => 'string', :length => 30).should be_valid
      end
    end

    it 'should validate for field types' do
      AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'Office', :field_type => 'string', :length => 30).should be_valid
      AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'Office', :field_type => 'integer', :length => 10).should be_valid
      AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'Office', :field_type => 'decimal', :length => 30, :precision => 2).should be_valid
      AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'Office', :field_type => 'unknown').should have_ar_errors(:field_type => :inclusion)

      ['boolean', 'date', 'datetime', 'file'].each do |field_type|
        AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'Office', :field_type => field_type).should be_valid
      end
    end

    it 'should validate length' do
      ['string', 'integer', 'decimal'].each do |field_type|
        AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'Office', :field_type => field_type, :precision => 2).should have_ar_errors(:length => :blank)
      end
    end

    it 'should validate name format' do
      Authorization::Maintenance.without_access_control do
        ['invalid name', 'invalid / name', 'invalid,name'].each do |invalid_name|
          addtional_attribute = AdditionalAttribute.new(:name => invalid_name, :resource_type => 'Office', :field_type => 'file')
          addtional_attribute.save
          addtional_attribute.should have_ar_errors(:name => :invalid)
        end
      end
    end

    it 'should validate uniqueness of name and resource type' do
      Authorization::Maintenance.without_access_control do
        existing_record = AdditionalAttribute.create(:name => 'valid_name', :resource_type => 'Office', :field_type => 'boolean')
        duplicate_record = AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'Office', :field_type => 'boolean')
        duplicate_record.should have_ar_errors(:name => :taken)

        valid_duplicate_record = AdditionalAttribute.new(:name => 'valid_name', :resource_type => 'User', :field_type => 'boolean')
        valid_duplicate_record.should be_valid
      end
    end

    describe 'name validation' do
      before(:each) do
        @resource = AdditionalAttribute.new(:resource_type => 'User', :field_type => 'string', :length => 30)
      end

      it_should_behave_like 'validates name'
    end
  end
end