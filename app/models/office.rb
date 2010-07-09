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
  validates_presence_of :office_type
  validate :office_type_validation
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

  alias :real_parent= :parent=

  def parent=(parent)
    self.real_parent = parent
    self.office_type = parent.office_type.child if parent
  end

  def parent_id=(parent_id)
    self.parent = Office.find(parent_id)
  end

  def html_options_for_parent
    childless_office_type = OfficeType.leaf
    self_and_children.select { |office|
      office.office_type != childless_office_type
    }.collect {|node|
      [node.name, node.id]
    }
  end

  def self.add_additional_attribute_column
    yield
  end

  protected
  def office_type_validation
    parent = self.parent
    office_type = self.office_type(true)
    errors.add(:office_type, :office_root_have_office_type_root) if head? && office_type != OfficeType.root
    errors.add(:office_type, :office_type_invalid) if parent && parent.office_type.child != office_type
  end
end