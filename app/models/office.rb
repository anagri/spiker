class Office < ActiveRecord::Base
  # authorization
  using_access_control
  
  # acts_as
  enhanced_acts_as_tree :order => :name

  # relationships
  belongs_to :office_type, :class_name => OfficeType.name
  has_many :personnels, :class_name => User.name

  # validations
  validates_name
  validates_presence_of :parent, :if => Proc.new {Office.root?}
  validates_presence_of :office_type

=begin
todo validation only one head office can exists office_type 
can be head|root for only one office that too is setup during migration
=end

  #todo validation parent should be of office_type parent to this office's office_type
  alias_method :head?, :root?
  class << self
    alias_method :head?, :root?
    alias_method :head, :root
  end
end