module DeclAuthSkipAccessControl
  def self.included(klass)
    klass.class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module MethodMissing
    include Authorization::Maintenance

    def method_missing(symbol, *args)
      if symbol.to_s =~ /^without_access_control_do_(.*)$/
        resource = without_access_control do
          self.send $1.to_sym, *args
        end
        return resource
      end
      super
    end
  end

  module ClassMethods
    include MethodMissing
  end

  module InstanceMethods
    include MethodMissing
  end
end

ActiveRecord::Base.send :include, DeclAuthSkipAccessControl
Authlogic::Session::Base.send :include, DeclAuthSkipAccessControl
