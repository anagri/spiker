class AddFailedLoginCountColumnToSessions < ActiveRecord::Migration
  def self.up
    add_column :users, :failed_login_count, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :users, :failed_login_count
  end
end

