require 'bindata'
require 'pio/parse_error'

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

      def self.body_option(name)
        unless class_variable_defined?(:@@valid_body_options)
          class_variable_set(:@@valid_body_options, [])
        end
        class_variable_set(:@@valid_body_options,
                           class_variable_get(:@@valid_body_options) + [name])
      end

      def initialize(user_options = {})
        validate_user_options user_options
        @format = self.class.const_get(:Format).new(parse_options(user_options))
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end

      private

      def validate_user_options(user_options)
        unknown_options =
          user_options.keys - valid_header_options - valid_body_options
        return if unknown_options.empty?
        fail "Unknown option: #{unknown_options.first}"
      end

      def parse_options(user_options)
        if valid_body_options.empty?
          { header: parse_header_options(user_options) }
        else
          { header: parse_header_options(user_options),
            body: parse_body_options(user_options) }
        end
      end

      def parse_header_options(user_options)
        transaction_id =
          user_options[:transaction_id] || user_options[:xid] || 0
        { transaction_id: transaction_id }
      end

      def parse_body_options(user_options)
        if valid_body_options.include?(:body)
          return user_options[:body] || user_options[:user_data] || ''
        end
        options = user_options.dup
        options.delete :transaction_id
        options.delete :xid
        dpid = options[:dpid]
        options[:datapath_id] = dpid if dpid
        options.empty? ? {} : options
      end

      def valid_header_options
        [:transaction_id, :xid]
      end

      def valid_body_options
        if self.class.class_variable_defined?(:@@valid_body_options)
          self.class.class_variable_get(:@@valid_body_options)
        else
          []
        end
      end
    end
  end
end
