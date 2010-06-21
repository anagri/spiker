class CreateOfficesTable < ActiveRecord::Migration
  def self.up
    create_table :offices do |t|
      t.string :name, :limit=> 30, :null => false
      t.references :parent
      t.timestamps
    end
  end

  def self.down
    drop_table :offices
  end
end
