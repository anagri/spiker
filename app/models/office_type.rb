class OfficeType < ActiveRecord::Base
  # authorization
  using_access_control

  # acts_as
  acts_as_hierarchy

  # relationships
  has_many :offices

  # validations
  validates_name
  validates_presence_of :parent, :if => Proc.new {OfficeType.head?}

  class << self
    alias_method :head, :root
    alias_method :head?, :root?
  end
end