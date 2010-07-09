class CreateAdditionalAttributesTable < ActiveRecord::Migration
  def self.up
    create_table :additional_attributes do |t|
      t.string :name, :limit => 30, :null => false
      t.string :resource_type, :null => false
      t.string :type, :null => false
      t.integer :length
      t.integer :precision
    end
  end

  def self.down
    drop_table :additional_attributes
  end
end
