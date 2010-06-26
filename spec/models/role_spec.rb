require File.dirname(__FILE__) + '/spec_helper'

describe Role do
  it 'should return all valid roles' do
    Role.roles.should == ['admin', 'manager', 'staff', 'loan_officer', 'client', 'maintenance']
  end

  it 'should return roles for select options' do
    Role.roles_for_select_option.should == [['Admin', 'admin'], ['Manager', 'manager'], ['Staff', 'staff'], ['Loan Officer', 'loan_officer'], ['Client', 'client'], ['Maintenance', 'maintenance']]
  end

  it 'should verify office roles' do
    [Role::MANAGER, Role::STAFF, Role::LOAN_OFFICER, Role::CLIENT].each {|role|
      Role.office_role?(role).should == true
    }
  end

  it 'should verify admin roles' do
    [Role::ADMIN, Role::MAINTENANCE].each {|role|
      Role.admin_role?(role).should == true
    }
  end
end