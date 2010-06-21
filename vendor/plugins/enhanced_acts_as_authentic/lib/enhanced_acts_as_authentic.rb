module EnhancedActsAsAuthentic
  def self.included(klass)
    klass.class_eval do
      extend ClassMethods
      extend Authorization::Maintenance
      include InstanceMethods
    end
  end

  module ClassMethods
    def enhanced_acts_as_authentic
      acts_as_authentic
    end

    def method_missing(symbol, *args)
      if symbol.to_s =~ /^without_access_control_do_(.*)$/
        resource = without_access_control do
          self.send $1.to_sym, args.shift, *args
        end
        return resource
      end
      super
    end
  end

  module InstanceMethods
  end
end

ActiveRecord::Base.send :include, EnhancedActsAsAuthentic