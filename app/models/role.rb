class Role
  def self.roles
    %w(admin manager staff loan_officer client maintenance)
  end

  ADMIN = 'admin'
  MANAGER = 'manager'
  STAFF = 'staff'
  LOAN_OFFICER ='loan_officer'
  CLIENT = 'client'
  MAINTENANCE ='maintenance'
end