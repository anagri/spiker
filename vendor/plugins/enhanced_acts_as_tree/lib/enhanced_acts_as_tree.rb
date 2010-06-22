module EnhancedActsAsTree
  def self.included(klass)
    klass.class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module ClassMethods
    def enhanced_acts_as_tree(options = {})
      acts_as_tree(options)
      order = (options[:order] || 'name').to_sym

      class_eval <<-EOV
        def self.root?
          root != nil
        end

        def self_and_children
          nodes = [self]
          nodes << children
          nodes.flatten.sort {|node1, node2| node1.send("#{order}") <=> node2.send("#{order}")}
        end

        def self_and_children_options
          self_and_children.collect {|node| [node.name, node.id]}
        end
      EOV
    end
  end

  module InstanceMethods
    def root?
      self == root
    end
  end
end

ActiveRecord::Base.send :include, EnhancedActsAsTree