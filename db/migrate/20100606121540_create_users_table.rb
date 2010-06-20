class CreateUsersTable < ActiveRecord::Migration
  def self.up
    create_table :users do |user|
      user.string :username, :null => false
      user.string :email, :null => false
      user.string :crypted_password, :null => false
      user.string :password_salt, :null => false
      user.string :persistence_token, :null => false
      user.timestamps
    end
  end

  def self.down
  end
end
