require 'forwardable'
require 'pio/open_flow'
require 'pio/open_flow10/message'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message.
  module Echo
    # OpenFlow 1.0 Echo Request message.
    class Request
      # OpenFlow 1.0 Hello message
      class Format < BinData::Record
        endian :big

        open_flow_header :header,
                         ofp_version_value: 1,
                         message_type_value: OpenFlow::ECHO_REQUEST
        virtual assert: -> { header.message_type == OpenFlow::ECHO_REQUEST }

        string :body
      end

      extend Forwardable

      def_delegators :@format, :snapshot
      def_delegators :snapshot, :header
      def_delegators :header, :ofp_version
      def_delegators :header, :message_type
      def_delegators :header, :message_length
      def_delegators :header, :transaction_id
      def_delegator :header, :transaction_id, :xid

      def_delegators :snapshot, :body
      def_delegator :snapshot, :body, :user_data
      def_delegator :@format, :to_binary_s, :to_binary

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Echo Request message.'
      end

      def initialize(user_options = {})
        header_options = OpenFlowHeader::Options.parse(user_options)
        body_options = user_options[:body] || user_options[:user_data] || ''
        @format = Format.new(header: header_options, body: body_options)
      end
    end

    # OpenFlow 1.0 Echo Reply message.
    class Reply
      # OpenFlow 1.0 Hello message
      class Format < BinData::Record
        endian :big

        open_flow_header :header,
                         ofp_version_value: 1,
                         message_type_value: OpenFlow::ECHO_REPLY
        virtual assert: -> { header.message_type == OpenFlow::ECHO_REPLY }

        string :body
      end

      extend Forwardable

      def_delegators :@format, :snapshot
      def_delegators :snapshot, :header
      def_delegators :header, :ofp_version
      def_delegators :header, :message_type
      def_delegators :header, :message_length
      def_delegators :header, :transaction_id
      def_delegator :header, :transaction_id, :xid

      def_delegators :snapshot, :body
      def_delegator :snapshot, :body, :user_data
      def_delegator :@format, :to_binary_s, :to_binary

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Echo Reply message.'
      end

      def initialize(user_options = {})
        header_options = OpenFlowHeader::Options.parse(user_options)
        body_options = user_options[:body] || user_options[:user_data] || ''
        @format = Format.new(header: header_options, body: body_options)
      end
    end
  end
end
