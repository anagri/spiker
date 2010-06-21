module EnhancedActsAsTree
  def self.included(klass)
    klass.class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module ClassMethods
    def enhanced_acts_as_tree(*opts)
      acts_as_tree(*opts)
      class_eval <<-EOV
        def self.root?
          root != nil
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