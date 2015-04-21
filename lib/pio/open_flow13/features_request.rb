require 'forwardable'
require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.3 Features Request and Reply message.
  class Features
    remove_const :Request

    # OpenFlow 1.3 Features Request message.
    class Request
      # OpenFlow 1.3 Features Request message format.
      class Format < BinData::Record
        extend Forwardable

        endian :big
        open_flow_header(:open_flow_header,
                         ofp_version_value: 4, message_type_value: 5)
        string :body, value: ''

        def_delegators :open_flow_header, :ofp_version
        def_delegators :open_flow_header, :message_type
        def_delegators :open_flow_header, :message_length
        def_delegators :open_flow_header, :transaction_id
        def_delegator :open_flow_header, :transaction_id, :xid
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Features Request 1.3 message.'
      end

      def initialize(user_attrs = {})
        unknown_attrs = user_attrs.keys - [:transaction_id, :xid]
        unless unknown_attrs.empty?
          fail "Unknown keyword: #{unknown_attrs.first}"
        end
        header_options = OpenFlowHeader::Options.parse(user_attrs)
        @format = Format.new(open_flow_header: header_options)
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end
  end
end
