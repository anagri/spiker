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

  def self.admin_role?(role)
    [ADMIN, MAINTENANCE].include?(role.to_s)
  end

  def self.office_role?(role)
    !admin_role?(role)
  end
end