module FactoryGirlDeclarativeAuthorizationExtension
  def self.included(klass)
    klass.class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module ClassMethods
    def without_access_control_do_create(factory_name, opts = {})
      without_access_control do
        Factory.create(factory_name, opts)
      end
    end
  end

  module InstanceMethods

  end
end

Factory.send :extend, Authorization::TestHelper
Factory.send :include, FactoryGirlDeclarativeAuthorizationExtension
