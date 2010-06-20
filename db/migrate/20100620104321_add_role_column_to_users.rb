class AddRoleColumnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string, :null => false, :default => 'none'
  end

  def self.down
    remove_column :users, :role
  end
end
