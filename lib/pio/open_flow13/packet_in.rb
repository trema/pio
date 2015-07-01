require 'bindata'
require 'pio/open_flow/open_flow_header'
require 'pio/open_flow13/match'
require 'pio/parser'

# Base module.
module Pio
  remove_const :PacketIn if const_defined?(:PacketIn)

  # OpenFlow 1.3 PacketIn message parser and generator
  class PacketIn
    # OpenFlow 1.3 PacketIn message format
    class Format < BinData::Record
      # OpenFlow 1.3 PacketIn message body
      class Body < BinData::Record
        # Why is this packet being sent to the controller?
        # (enum ofp_packet_in_reason)
        class Reason < BinData::Primitive
          REASONS = { no_match: 0, action: 1, invalid_ttl: 2 }

          uint8 :reason

          def get
            REASONS.invert.fetch(reason)
          end

          def set(value)
            self.reason = REASONS.fetch(value)
          end
        end

        endian :big

        uint32 :buffer_id
        uint16 :total_len, initial_value: -> { raw_data.length }
        reason :reason
        uint8 :table_id
        uint64 :cookie
        oxm :match
        string :padding, length: 2
        hide :padding
        string :raw_data, read_length: :total_len

        def length
          16 + match.length + padding.length + raw_data.length
        end

        def data
          @data ||= Pio::Parser.read(raw_data)
        end

        def method_missing(method, *args)
          data.__send__(method, *args).snapshot
        end
      end

      extend Forwardable

      endian :big

      open_flow_header :open_flow_header,
                       ofp_version_value: 4, message_type_value: 10
      body :body

      def_delegators :open_flow_header, :ofp_version
      def_delegators :open_flow_header, :message_type
      def_delegators :open_flow_header, :message_length
      def_delegators :open_flow_header, :transaction_id
      def_delegator :open_flow_header, :transaction_id, :xid

      attr_accessor :datapath_id
      alias_method :dpid, :datapath_id
      alias_method :dpid=, :datapath_id=

      def method_missing(method, *args, &block)
        body.__send__ method, *args, &block
      end
    end

    def self.read(raw_data)
      allocate.tap do |message|
        message.instance_variable_set(:@format, Format.read(raw_data))
      end
    end

    def initialize(user_attrs = {})
      header_attrs = OpenFlowHeader::Options.parse(user_attrs)
      body_attrs = { raw_data: user_attrs[:raw_data] }
      @format = Format.new(open_flow_header: header_attrs, body: body_attrs)
    end

    def method_missing(method, *args, &block)
      @format.__send__ method, *args, &block
    end
  end
end
