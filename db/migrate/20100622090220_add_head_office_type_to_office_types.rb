class AddHeadOfficeTypeToOfficeTypes < ActiveRecord::Migration
  def self.up
    Authorization::Maintenance.without_access_control do
      OfficeType.reset_column_information

      OfficeType.create!(:name => 'Head Office', :parent => nil)
    end
  end

  def self.down
    Authorization::Maintenance.without_access_control do
      OfficeType.find_by_name('Head Office').try(:destroy)
    end
  end
end
