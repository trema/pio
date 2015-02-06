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

    # Pio::PacketIn#data parser
    class DataParser
      # Ethernet header parser
      class EthernetHeaderParser < BinData::Record
        extend Pio::Type::EthernetHeader

        endian :big

        ethernet_header
        rest :payload
      end

      # IPv4 packet parser
      class IPv4Packet < BinData::Record
        extend Pio::Type::EthernetHeader
        extend Type::IPv4Header

        endian :big

        ethernet_header
        ipv4_header

        uint16 :transport_source_port
        uint16 :transport_destination_port
        rest :rest
      end

      def self.read(raw_data)
        ethernet_header = EthernetHeaderParser.read(raw_data)
        case ethernet_header.ether_type
        when 0x0800
          IPv4Packet.read raw_data
        when 0x0806
          Pio::Arp.read raw_data
        else
          fail 'Failed to parse packet_in data.'
        end
      end
    end

    def_delegators :body, :buffer_id
    def_delegators :body, :total_len
    def_delegators :body, :in_port
    def_delegators :body, :reason
    def_delegators :body, :data

    def parsed_data
      @parsed_data ||= DataParser.read(data)
    end

    def source_mac
      parsed_data.source_mac
    end

    def destination_mac
      parsed_data.destination_mac
    end
  end
end
