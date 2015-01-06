require 'forwardable'

module Pio
  module OpenFlow
    # Defines shortcuts to OpenFlow header fields.
    class Message
      extend Forwardable

      def_delegators :@format, :open_flow_header
      def_delegators :open_flow_header, :ofp_version
      def_delegators :open_flow_header, :message_type
      def_delegators :open_flow_header, :message_length
      def_delegators :open_flow_header, :transaction_id
      def_delegator :open_flow_header, :transaction_id, :xid
      def_delegators :@format, :body
      def_delegator :@format, :body, :user_data
      def_delegator :@format, :to_binary_s, :to_binary

      # rubocop:disable MethodLength
      def self.def_format(message_type)
        str = %(
         class Format < BinData::Record
           endian :big

           open_flow_header :open_flow_header,
                            message_type_value: #{message_type}
           virtual assert: -> do
             open_flow_header.message_type == #{message_type}
           end

           body :body
         end
        )
        module_eval str
      end
      # rubocop:enable MethodLength

      # @reek This method smells of :reek:FeatureEnvy
      def initialize(user_options)
        header_options = { transaction_id: user_options[:transaction_id] ||
                                           user_options[:xid] || 0 }
        format_klass = self.class.const_get(:Format)
        @format = format_klass.new(open_flow_header: header_options,
                                   body: user_options)
      end
    end
  end
end
