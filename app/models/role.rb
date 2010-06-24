class Role
  ADMIN = 'admin'
  MANAGER = 'manager'
  STAFF = 'staff'
  LOAN_OFFICER ='loan_officer'
  CLIENT = 'client'
  MAINTENANCE ='maintenance'

  def self.roles
    [ADMIN, MANAGER, STAFF, LOAN_OFFICER, CLIENT, MAINTENANCE]
  end

  def self.roles_for_select_option
    roles.collect {|role| [I18n.t("role.#{role}"), role]}
  end

  def self.office_roles
    [MANAGER, STAFF, LOAN_OFFICER, CLIENT]
  end

  def self.admin_roles
    [ADMIN, MAINTENANCE]
  end
end