class CreateUsersTable < ActiveRecord::Migration
  def self.up
    create_table :users do |user|
      user.string :username, :limit => 30, :null => false
      user.string :email, :limit=> 30, :null => false
      user.string :crypted_password, :null => false
      user.string :password_salt, :null => false
      user.string :persistence_token, :null => false
      user.integer :failed_login_count, :null => false, :default => 0
      user.string :role, :null => false
      user.string :perishable_token, :null => false
      user.references :office, :null => false
      user.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
