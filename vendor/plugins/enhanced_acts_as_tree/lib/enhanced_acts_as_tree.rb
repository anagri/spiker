module EnhancedActsAsTree

  def enhanced_acts_as_tree(options = {})
    acts_as_tree(options)

    validates_presence_of :parent, :if => :is_self_not_root_and_root_exists?
    validate :circular_hierarchy

    order = (options[:order] || 'name').to_sym

    class_eval <<-EOV
      def self_and_children(sort = false)
        nodes = [self]
        nodes << children.collect {|child| child.self_and_children}
        nodes.flatten!
        nodes.sort! {|node1, node2| node1.send("#{order}") <=> node2.send("#{order}")} if sort
        nodes
      end
    EOV

    class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module ClassMethods
    def root?
      root != nil
    end
  end

  module InstanceMethods
    def root?
      self == root
    end

    def self_and_children_options
      self_and_children.collect {|node| [node.name, node.id]}
    end

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
end

ActiveRecord::Base.send :extend, EnhancedActsAsTree