class Role
  def self.roles
    %w(admin manager staff loan_officer client maintenance)
  end

  roles.each do |role|
    self.send :const_set, role.upcase, role
  end
end