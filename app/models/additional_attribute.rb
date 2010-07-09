class AdditionalAttribute < ActiveRecord::Base
  # authorization
  using_access_control

  #callbacks
  before_save :create_additional_columns

  # acts as

  # relationships

  # validation methods
  def self.field_types
    [
            BooleanAttribute,
            DateAttribute,
            DatetimeAttribute,
            DecimalAttribute,
            FileAttribute,
            IntegerAttribute,
            StringAttribute,
            TextAttribute
    ]
  end

  def self.resource_types
    [
            User,
            Office
    ]
  end

  # validations
  validate :name_available

  validates_length_of :name, :maximum => 30, :allow_nil => true, :allow_blank => true #checking for nil|blank in presence of
  validates_presence_of :name
  validates_format_of :name, :with => /\A([a-z0-9_]+)\Z/i, :unless => Proc.new {|record| record.name.blank?}

  validates_presence_of :type
  validates_inclusion_of :type, :in => field_types.map(&:name)

  validates_inclusion_of :resource_type, :in => resource_types.map(&:name)

  def self.resource_types_for_select
    resource_types.collect {|resource_type| [resource_type.name, resource_type.name]}
  end

  def self.field_types_for_select
    field_types.collect {|field_type| [field_type.display_name, field_type.name]}
  end

  def self.display_name
    name.demodulize.gsub(/Attribute/, '')
  end

  def display_name
    self.class.display_name
  end

  def column_type
    display_name.downcase
  end

  def self.valid_field_type?(field_type)
    field_types.map(&:name).include?(field_type)
  end

  delegate :resource_types, :to => self

  protected
  def name_available
    if resource_type && resource_types.map(&:name).include?(resource_type)
      resource_class = resource_type.constantize
      resource_class.reset_column_information
      errors.add(:name, :taken) if resource_class.column_names.include?(name)
    end
  end

  def create_additional_columns
#      begin
    resource_class = resource_type.constantize
    resource_class.add_additional_attribute_column do
      connection.add_column(resource_type.tableize.to_sym,
                            name,
                            column_type,
                            :length => length.to_i,
                            :precision => precision.to_i)
      resource_class.reset_column_information
    end
#      rescue Exception => e
#        pp e
#      end
  end
end