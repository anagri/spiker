class CreateClientTypeRelationshipsTable < ActiveRecord::Migration
  def self.up
    create_table :client_type_relationships, :id => false do |t|
      t.references :parent
      t.references :child
    end
  end

  def self.down
    drop_table :client_type_relationships
  end
end
