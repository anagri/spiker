require File.dirname(__FILE__) + '/spec_helper'

describe RestrictAttributesUpdate do
  it 'should add restrict_attributes_update class method' do
    ActionController::Base.method_defined?(:restrict_attributes_update)
  end
end
