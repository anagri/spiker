module RestrictAttributesUpdate
  def self.included(klass)
    klass.class_eval do
      extend ClassMethods
    end
  end

  module ClassMethods
    def restrict_attributes_update(attributes)
      before_filter :only => [:update] do |controller|
        attributes.each {|attribute| controller.params.delete(attribute.to_sym)}
      end
    end
  end
end

::ActionController::Base.send :include, RestrictAttributesUpdate