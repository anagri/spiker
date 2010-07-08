Factory.sequence(:office_name) {|n| "office_#{n}"}

Factory.define :office do |o|
  o.name {Factory.next(:office_name)}
  o.parent {Office.root}
end