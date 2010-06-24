class CreateClientTypesTable < ActiveRecord::Migration
  def self.up
    create_table :client_types do |t|
      t.string :name, :limit => 30, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :client_types
  end
end
