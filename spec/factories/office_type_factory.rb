Factory.sequence(:office_type_name) {|n| "office_type_#{n}"}

Factory.define :office_type do |o|
  o.name {Factory.next(:office_type_name)}
  o.parent {OfficeType.root}
end