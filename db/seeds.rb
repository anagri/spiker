Authorization::Maintenance.without_access_control do
# seed office_type
  OfficeType.delete_all
  OfficeType.create!(:name => 'Head Office', :parent => nil)

# seed office

  Office.delete_all
  Office.create!(:name => 'Head Office', :office_type => OfficeType.root)

# seed user
  User.create!(:username => 'admin', :password => 'changeme', :password_confirmation => 'changeme', :email => 'spiker.app@gmail.com', :role => Role::ADMIN, :office => Office.root)
end
