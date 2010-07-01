class AdditionalAttribute < ActiveRecord::Base
  # authorization
  using_access_control

  #callbacks
  before_save :create_additional_columns

  # acts as

  # relationships

  # validation methods
  def self.field_types
    ['string', 'integer', 'decimal', 'boolean', 'date', 'datetime', 'file']
  end

  def self.resource_types
    [User, Office]
  end

  # validations
  validates_uniqueness_of :name, :scope => :resource_type
  validates_length_of :name, :maximum => 30, :allow_nil => true, :allow_blank => true #checking for nil|blank in presence of
  validates_presence_of :name
  validates_format_of :name, :with => /\A([a-z0-9_]+)\Z/i, :unless => Proc.new {|record| record.name.blank?}

  validates_inclusion_of :resource_type, :in => resource_types.map(&:name)
  validates_inclusion_of :field_type, :in => field_types
  validates_presence_of :length, :if => Proc.new {|record| record.field_type && ['string', 'integer', 'decimal'].include?(record.field_type)}
  validates_presence_of :precision, :if => Proc.new {|record| record.field_type && ['decimal'].include?(record.field_type)}

  def self.field_types_for_select
    field_types.map {|field_type| [field_type, field_type]}
  end

  def self.resource_types_for_select
    resource_types.map {|resource_type| [resource_type.name, resource_type.name]}
  end

  protected
  def create_additional_columns
    connection.add_column(resource_type.tableize.to_sym,
                          name,
                          field_type.to_sym,
                          :length => length.to_i)
    resource_type.constantize.reset_column_information
  end
end