class ClientType < ActiveRecord::Base
  # authorization
  using_access_control

  #association
  has_many :lineages, :foreign_key => 'parent_id', :class_name => 'ClientTypeRelationship', :dependent => :delete_all
  has_many :ancestry, :foreign_key => 'child_id', :class_name => 'ClientTypeRelationship', :dependent => :delete_all
  has_many :children, :through => :lineages
  has_many :parents, :through => :ancestry

  #validations


  def self.roots
    find(all.map(&:id) - ClientTypeRelationship.all.map(&:child_id).uniq)
  end
end
