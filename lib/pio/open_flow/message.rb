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

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end
  end
end
