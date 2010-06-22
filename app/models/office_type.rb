class OfficeType < ActiveRecord::Base
  using_access_control
  
  validates_uniqueness_of :name
  validates_presence_of :parent, :if => Proc.new {OfficeType.root?}

  belongs_to :parent, :class_name => OfficeType

  has_one :child, :class_name => OfficeType, :foreign_key => :parent_id

  has_many :offices
  def self.root
    find(:first, :conditions => "PARENT_ID IS NULL")
  end

  def self.root?
    root != nil
  end
end