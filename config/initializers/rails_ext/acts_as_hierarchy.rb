module ActsAsHierarchy
  def acts_as_hierarchy
    belongs_to :parent, :class_name => self.name
    has_one :child, :class_name => name, :foreign_key => :parent_id
    validate :circular_hierarchy
    validates_presence_of :parent, :if => :is_self_not_root_and_root_exists?
    class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module InstanceMethods
    def ancestors
      node, nodes = self, []
      nodes << node = node.parent while node.parent && !nodes.include?(self)
      nodes.reverse
    end

    def ancestors_including_self
      ancestors << self
    end

    private
    def circular_hierarchy
      errors.add(:parent, :circular_hierarchy) if ancestors.include?(self)
    end

    def is_self_not_root_and_root_exists?
      self.class.root? && self != self.class.root
    end
  end

  module ClassMethods
    def root
      find(:first, :conditions => "PARENT_ID IS NULL")
    end

    def leaf
      leaf = root
      leaf = leaf.child while leaf.child
      leaf
    end

    def root?
      root != nil
    end
  end
end

ActiveRecord::Base.send :extend, ActsAsHierarchy

