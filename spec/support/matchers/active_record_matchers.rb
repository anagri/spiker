module ActiveRecord
  module Matchers
    class HaveARErrors
      def initialize(field_error_map)
        field_error_map.each {|k, v|
          field_error_map[k] = v.class == Array ? v : [v]
        }
        @field_error_map = field_error_map
        @field_error_map.instance_eval do
          def error_count
            self.inject(0) {|sum, k|
              sum + self[k[0]].size
            }
          end
        end
      end

      def matches?(record)
        @record = record
        @actual_errors = @record.errors
        @actual_errors.instance_eval do
          def field_error_map
            return @field_error_map if @field_error_map
            @field_error_map = {}
            each_error {|attr, error|
              (@field_error_map[attr] ||= []) << error.type
            }
            @field_error_map
          end
        end
        @message = "expected the record valid? to be false but was #{@record.valid?}" and return false if @record.valid? == true

        @message = error_count_mismatch and return false unless @actual_errors.size == @field_error_map.error_count
        @actual_errors.each_error {|attr, error|
          @message = "expected  error #{error.type} on #{attr} but was not present" and return false unless @field_error_map[attr.to_sym] && @field_error_map[attr.to_sym].include?(error.type)
        }
      end

      def failure_message_for_should
        @message
      end

      def failure_message_for_should_not
        "expected #{@actual_errors} not to be same as #{@field_error_map} but were"
      end

      private
      def error_count_mismatch
        "expected the errors count to be same. actual errors(#{@actual_errors.size}) were #{@actual_errors.field_error_map.inspect} but expected(#{@field_error_map.error_count} was #{@field_error_map.inspect}"
      end

    end

    def have_ar_errors(field_error_map)
      HaveARErrors.new(field_error_map)
    end
  end
end
