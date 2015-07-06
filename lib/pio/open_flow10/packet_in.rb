require 'pio/ethernet_header'
require 'pio/ipv4_header'
require 'pio/open_flow'
require 'pio/parse_error'
require 'pio/parser'

# Base module.
module Pio
  # OpenFlow 1.0 Packet-In message
  class PacketIn < OpenFlow::Message
    # Why is this packet being sent to the controller?
    # (enum ofp_packet_in_reason)
    class Reason < BinData::Primitive
      REASONS = { no_match: 0, action: 1 }

      uint8 :reason

      def get
        REASONS.invert.fetch(reason)
      end

      def set(value)
        self.reason = REASONS.fetch(value)
      end
    end

    # Message body of Packet-In.
    class Body < BinData::Record
      endian :big

      uint32 :buffer_id
      uint16 :total_len, value: -> { raw_data.length }
      uint16 :in_port
      reason :reason
      uint8 :padding
      hide :padding
      string :raw_data, read_length: :total_len

      def data
        @data ||= Pio::Parser.read(raw_data)
      end

      def empty?
        false
      end

      def length
        10 + raw_data.length
      end

      def lldp?
        data.is_a? Lldp
      end

      def method_missing(method, *args)
        data.__send__(method, *args).snapshot
      end
    end

    attr_accessor :datapath_id
    alias_method :dpid, :datapath_id
    alias_method :dpid=, :datapath_id=

    # OpenFlow 1.0 Flow Mod message format.
    class Format < BinData::Record
      extend OpenFlow::Format

      header version: 1, message_type: OpenFlow::PACKET_IN
      body :body
    end

    # rubocop:disable MethodLength
    def initialize(user_options = {})
      header_options = OpenFlowHeader::Options.parse(user_options)
      body_options = if user_options.respond_to?(:fetch)
                       user_options.delete :transaction_id
                       user_options.delete :xid
                       dpid = user_options[:dpid]
                       user_options[:datapath_id] = dpid if dpid
                       user_options
                     else
                       ''
                     end
      @format = Format.new(header: header_options, body: body_options)
    end
    # rubocop:enable MethodLength
  end
end
