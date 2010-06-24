class OfficeType < ActiveRecord::Base
  # authorization
  using_access_control

  # acts_as
  acts_as_hierarchy

  # relationships
  has_many :offices

  # validations
  validates_name

  class << self
    alias_method :head, :root
    alias_method :head?, :root?
  end
end