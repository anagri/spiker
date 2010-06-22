class Office < ActiveRecord::Base
  enhanced_acts_as_tree :order => :name
  alias_method :head_office?, :root?
  
  belongs_to :office_type
  has_many :personnels, :class_name => User

  validates_uniqueness_of :name
  validates_presence_of :parent, :if => Proc.new {Office.root?}
  validates_presence_of :office_type
end