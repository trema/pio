module Pio
  module OpenFlow
    # OpenFlow messages.
    class Message
      # rubocop:disable MethodLength
      def self.inherited(child)
        child.class_eval <<-EOS
          def self.read(raw_data)
            allocate.tap do |message|
              format_klass = self.const_get(:Format)
              message.instance_variable_set(:@format,
                                            format_klass.read(raw_data))
            end
          rescue BinData::ValidityError
            message_name = name.split('::')[1..-1].join(' ')
            raise Pio::ParseError, "Invalid \#{message_name} message."
          end
        EOS
      end
      # rubocop:enable MethodLength

      def self.user_option(name)
        unless class_variable_defined?(:@@valid_options)
          class_variable_set(:@@valid_options, [])
        end
        class_variable_set(:@@valid_options,
                           class_variable_get(:@@valid_options) + [name])
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end

      private

      def validate_user_options(user_options)
        unknown_options = user_options.keys - valid_options
        return if unknown_options.empty?
        fail "Unknown option: #{unknown_options.first}"
      end

      def valid_options
        self.class.class_variable_get(:@@valid_options)
      end
    end
  end
end
