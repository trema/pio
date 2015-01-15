require 'bindata'
require 'pio/open_flow'
require 'pio/parse_error'

module Pio
  # OpenFlow 1.0 Packet-In message
  class PacketIn < OpenFlow::Message.factory(OpenFlow::Type::PACKET_IN)
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
    class PacketInBody < BinData::Record
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

    def_delegators :body, :buffer_id
    def_delegators :body, :total_len
    def_delegators :body, :in_port
    def_delegators :body, :reason
    def_delegators :body, :data
  end
end
