class ClientTypeRelationship < ActiveRecord::Base
  belongs_to :parent, :class_name => 'ClientType'
  belongs_to :child, :class_name => 'ClientType'
end