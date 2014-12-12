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
    end
  end
end
