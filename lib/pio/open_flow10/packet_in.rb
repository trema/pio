require 'pio/open_flow/message'
require 'pio/open_flow10/packet_in/reason'
require 'pio/parser'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Packet-In message
    class PacketIn < OpenFlow::Message
      open_flow_header version: 1,
                       type: 10,
                       length: -> { header_length + 10 + raw_data.length }
      uint32 :buffer_id
      uint16 :total_length, value: -> { raw_data.length }
      uint16 :in_port
      reason :reason
      uint8 :padding
      hide :padding
      string :raw_data, read_length: :total_length

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
      alias dpid datapath_id
      alias dpid= datapath_id=
    end
  end
end
