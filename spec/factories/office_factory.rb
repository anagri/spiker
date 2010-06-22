Factory.sequence(:office_name) {|n| "office_#{n}"}

Factory.define :office do |o|
  o.name {Factory.next(:username)}
  o.parent {Office.root}
end