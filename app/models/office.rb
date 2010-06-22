class Office < ActiveRecord::Base
  enhanced_acts_as_tree :order => :name
  alias_method :head_office?, :root?

  validates_uniqueness_of :name
  validates_presence_of :parent, :if => Proc.new {Office.root?}

  has_many :personnels, :class_name => User
end