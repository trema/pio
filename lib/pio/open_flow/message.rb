require 'English'
require 'bindata'
require 'forwardable'
require 'pio/parse_error'

module Pio
  module OpenFlow
    # Defines shortcuts to OpenFlow header fields.
    class Message
      extend Forwardable

      # struct ofp_header fields.
      def_delegators :@format, :open_flow_header
      def_delegators :open_flow_header, :ofp_version
      def_delegators :open_flow_header, :message_type
      def_delegators :open_flow_header, :message_length
      def_delegators :open_flow_header, :transaction_id
      def_delegator :open_flow_header, :transaction_id, :xid

      def_delegators :@format, :body
      def_delegator :@format, :body, :user_data

      def_delegator :@format, :to_binary_s, :to_binary

      def self.factory(message_type)
        @message_type = message_type
        self
      end

      def self.klass(message_type)
        @messages.fetch(message_type)
      end

      def self.inherited(child)
        child.const_set(:MESSAGE_TYPE, @message_type)
        @messages ||= {}
        @messages[@message_type] = child
      end

      def self.read(raw_data)
        message = allocate
        message.instance_variable_set(:@format, format.read(raw_data))
        message
      rescue BinData::ValidityError
        message_name = name.split('::')[1..-1].join(' ')
        raise Pio::ParseError, "Invalid #{message_name} message."
      end

      def self.format
        const_get(:Format)
      rescue NameError
        define_message_format const_get(:MESSAGE_TYPE)
        retry
      end

      # rubocop:disable MethodLength
      def self.define_message_format(message_type)
        code = %(
          class Format < BinData::Record
            endian :big

            open_flow_header :open_flow_header,
                             message_type_value: #{message_type}
            virtual assert: -> do
              open_flow_header.message_type == #{message_type}
            end

            #{body_type} :body
          end
        )
        module_eval code
      end
      # rubocop:enable MethodLength

      def self.body_type
        klass_name = name.split('::').last + 'Body'
        const_get(klass_name)
        klass_name.sub(/.*::/, '').
          gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
          gsub(/([a-z\d])([A-Z])/, '\1_\2').
          tr('-', '_').
          downcase
      rescue NameError
        'string'
      end

      def initialize(user_options = {})
        header_options = parse_header_options(user_options)
        body_options = parse_body_options(user_options)
        @format = self.class.format.new(open_flow_header: header_options,
                                        body: body_options)
      end

      private

      # This method smells of :reek:FeatureEnvy
      def parse_header_options(options)
        xid = if options.respond_to?(:to_i)
                options.to_i
              elsif options.respond_to?(:fetch)
                options[:transaction_id] || options[:xid] || 0
              else
                fail TypeError
              end
        return { transaction_id: xid } if xid.unsigned_32bit?
        fail(ArgumentError,
             'Transaction ID should be an unsigned 32-bit integer.')
      end

      # rubocop:disable MethodLength
      # This method smells of :reek:TooManyStatements
      # This method smells of :reek:FeatureEnvy
      # This method smells of :reek:UtilityFunction
      def parse_body_options(options)
        if options.respond_to?(:fetch)
          options.delete :transaction_id
          options.delete :xid
          dpid = options[:dpid]
          options[:datapath_id] = dpid if dpid
          if options.keys.size > 1
            options
          else
            options[:user_data] || ''
          end
        else
          ''
        end
      end
      # rubocop:enable MethodLength
    end
  end
end
