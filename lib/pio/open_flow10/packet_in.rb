require 'pio/ethernet_header'
require 'pio/ipv4_header'
require 'pio/open_flow'
require 'pio/parse_error'
require 'pio/parser'

module Pio
  module OpenFlow10
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

      open_flow_header version: 1,
                       message_type: 10,
                       message_length: -> { 18 + raw_data.length }
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

      def lldp?
        data.is_a? Lldp
      end

      def method_missing(method, *args)
        data.__send__(method, *args).snapshot
      end

      attr_accessor :datapath_id
      alias_method :dpid, :datapath_id
      alias_method :dpid=, :datapath_id=
    end
  end
end
