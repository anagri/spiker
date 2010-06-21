class AddAdminUserDataToUsers < ActiveRecord::Migration
  def self.up
    User.reset_column_information

    # fixme no i18n, config
    # add admin user

    User.create(:username => 'admin',
                :crypted_password => 'e44d202e99800020be7a54d366637c6f4916a30cca4668b9a777d59ee00ce73ac41adc47641423229be2d6fb4792f3ae406372af9049c45f9ad6bf015ef1155e',
                :password_salt => 'Z0eceFDI5BEG0wTUrAfE',
                :persistence_token => 'd0bd93f14840822bbe9210aac8c7c1bf2092d643b07c917beadb8ec4d3d589a4990b5949bea8e3d3d69c722d0e7901c6e1298d10b4bd9e3b8279d30626716e99',
                :email => 'spiker.app@gmail.com',
                :role => User::ADMIN, 
                :force_change_password => true)
  end

  def self.down
    User.find_by_username('admin').destroy
  end
end
