Factory.sequence(:additional_attribute_name) {|n| "test_additional_attribute_#{n}"}

Factory.define :string_attribute do |additional_attribute|
  additional_attribute.name {Factory.next(:additional_attribute_name)}
  additional_attribute.resource_type 'User'
  additional_attribute.length '30'
end

