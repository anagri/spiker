module EnhancedEnumAttr
  def self.included(klass)
    klass.class_eval do
      extend ClassMethods
    end
  end

  module ClassMethods
    def enhanced_enum_attr(*opts)
      enums = opts[1].clone
      enum_attr *opts
      enums.each do |enum|
        self.send :const_set, enum.upcase, enum.to_sym
      end
    end
  end
end

ActiveRecord::Base.send :include, EnhancedEnumAttr