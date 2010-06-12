module Spiker
  module RequestUtils
    def self.included(klass)
      klass.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module InstanceMethods
      def method_missing(sym, *args, &block)
        if sym.to_s =~ /^(get|post|put|delete|head)_(html|xml|json|js)(|_with)$/
          if args.last.is_a? Hash
            args.last.reverse_merge!({:format => $2})
          else
            args << {:format => $2}
          end
          login(args.shift) unless $3.blank?
          return send($1.to_sym, *args, &block)
        end
        super
      end
    end

    module ClassMethods
    end
  end
end

include Spiker::RequestUtils