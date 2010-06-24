Factory.sequence(:client_type_name) {|n| "client_type_#{n}"}

Factory.define :client_type do |o|
  o.name {Factory.next(:client_type_name)}
end