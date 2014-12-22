require 'bindata'
require 'pio/open_flow'

module Pio
  class PacketIn < Pio::OpenFlow::Message
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
      uint16 :total_len, value: -> { data.length }
      uint16 :in_port
      reason :reason
      uint8 :padding
      hide :padding
      string :data, read_length: :total_len

      def empty?
        false
      end

      def length
        10 + data.length
      end
    end

    # OpenFlow 1.0 Packet-In message parser and generator.
    class Format < BinData::Record
      include Pio::OpenFlow::Type

      endian :big

      open_flow_header :open_flow_header, message_type_value: PACKET_IN
      virtual assert: -> { open_flow_header.message_type == PACKET_IN }

      body :body
    end
  end
end
