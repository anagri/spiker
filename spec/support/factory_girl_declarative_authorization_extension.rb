module FactoryGirlDeclarativeAuthorizationExtension
  def self.included(klass)
    klass.class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module ClassMethods
    def method_missing(symbol, *args)
      if symbol.to_s =~ /^without_access_control_do_(.*)$/
        resource = without_access_control do
          Factory.send $1.to_sym, args.shift, *args
        end
        return resource
      end
      super
    end
  end

  module InstanceMethods

  end
end

Factory.send :extend, Authorization::TestHelper
Factory.send :include, FactoryGirlDeclarativeAuthorizationExtension
