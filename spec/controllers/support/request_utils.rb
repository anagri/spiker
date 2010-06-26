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

def view_actions
  show_actions + index_actions
end

def manage_actions
  build_actions + modify_actions
end

def build_actions
  Set['new', 'create', 'show']
end

def modify_actions
  Set['edit', 'update', 'show']
end

def show_actions
  Set['show']
end

def index_actions
  Set['index']
end

def none_actions
  Set[]
end