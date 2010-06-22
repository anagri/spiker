class CreateOfficeTypesTable < ActiveRecord::Migration
  def self.up
    create_table :office_types do |t|
      t.string :name, :limit => 30, :null => false
      t.references :parent
      t.timestamps
    end
  end

  def self.down
    drop_table :office_types
  end
end
