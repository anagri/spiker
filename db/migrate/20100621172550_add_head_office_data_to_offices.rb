class AddHeadOfficeDataToOffices < ActiveRecord::Migration
  def self.up
    Office.reset_column_information

    # create head office
    # fixme no i18n, config
    Office.create!(:name => 'Head Office')
  end

  def self.down
    Office.find_by_name('Head Office').try(:destroy)
  end
end
