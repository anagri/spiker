class AddForceChangePasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :force_change_password, :boolean
  end

  def self.down
    remove_column :users, :force_change_password
  end
end
