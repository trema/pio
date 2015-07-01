require 'bindata'
require 'pio/open_flow13/actions'
require 'pio/open_flow13/buffer_id'

# Base module.
module Pio
  remove_const :PacketOut

  # OpenFlow 1.3 PacketOut message parser and generator
  class PacketOut
    # Packet's input port or :controller
    class InPort < BinData::Primitive
      CONTROLLER = 0xfffffffd

      endian :big
      uint32 :in_port

      def get
        (in_port == CONTROLLER) ? :controller : in_port
      end

      def set(value)
        self.in_port = (value == :controller ? NO_CONTROLLER : value)
      end
    end

    # OpenFlow 1.3 PacketOut message body
    class Body < BinData::Record
      endian :big

      buffer_id :buffer_id
      in_port :in_port
      uint16 :actions_length, initial_value: -> { actions.binary.length }
      string :padding, length: 6
      actions :actions, length: :actions_length
      string :raw_data, read_length: -> { message_length - 24 - actions_length }

      def length
        10 + padding.length + actions_length + raw_data.length
      end

      def data
        @data ||= Pio::Parser.read(raw_data)
      end

      def method_missing(method, *args)
        data.__send__(method, *args).snapshot
      end
    end

    # OpenFlow 1.3 PacketOut message body
    class Format < BinData::Record
      extend Forwardable

      endian :big

      open_flow_header :open_flow_header,
                       ofp_version_value: 4, message_type_value: 13
      body :body

      def_delegators :open_flow_header, :ofp_version
      def_delegators :open_flow_header, :message_type
      def_delegators :open_flow_header, :message_length
      def_delegators :open_flow_header, :transaction_id
      def_delegator :open_flow_header, :transaction_id, :xid

      alias_method :to_binary, :to_binary_s

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
      body_attrs = { actions: user_attrs[:actions],
                     raw_data: user_attrs[:raw_data] }
      @format = Format.new(open_flow_header: header_attrs,
                           body: body_attrs)
    end

    def method_missing(method, *args, &block)
      @format.__send__ method, *args, &block
    end
  end
end
