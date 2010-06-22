class AddHeadOfficeDataToOffices < ActiveRecord::Migration
  def self.up
    Authorization::Maintenance.without_access_control do
      Office.reset_column_information
      OfficeType.reset_column_information

      # create head office
      # fixme no i18n, config
      Office.create!(:name => 'Head Office', :office_type => OfficeType.root)
    end
  end

  def self.down
    Authorization::Maintenance.without_access_control do
      Office.find_by_name('Head Office').try(:destroy)
    end
  end
end
