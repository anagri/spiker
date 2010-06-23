ActiveRecord::Base.class_eval <<-EOV
  def self.validates_name
    validates_uniqueness_of :name
    validates_length_of :name, :maximum => 30, :allow_nil => true, :allow_blank => true #checking for nil|blank in presence of
    validates_presence_of :name
  end

  def self.acts_as_hierarchy
    belongs_to :parent, :class_name => name
    has_one :child, :class_name => name, :foreign_key => :parent_id
  end

  def self.root
    @@root ||= find(:first, :conditions => "PARENT_ID IS NULL")
  end

  def self.root?
    root != nil
  end
EOV