require 'bindata'
require 'pio/ethernet_header'
require 'pio/ipv4_header'
require 'pio/open_flow'
require 'pio/parse_error'

# Base module.
module Pio
  # OpenFlow 1.0 Packet-In message
  class PacketIn
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

    # Pio::PacketIn#data parser
    class DataParser
      # Ethernet header parser
      class EtherTypeParser < BinData::Record
        endian :big

        mac_address :destination_mac
        mac_address :source_mac
        uint16 :ether_type
      end

      # IPv4 packet parser
      class IPv4Packet < BinData::Record
        include EthernetHeader
        include IPv4Header

        endian :big

        ethernet_header ether_type: EthernetHeader::EtherType::IPV4
        ipv4_header

        uint16 :transport_source_port
        uint16 :transport_destination_port
        rest :rest
      end

      # rubocop:disable MethodLength
      def self.read(raw_data)
        ethernet_header = EtherTypeParser.read(raw_data)
        case ethernet_header.ether_type
        when EthernetHeader::EtherType::IPV4
          IPv4Packet.read raw_data
        when EthernetHeader::EtherType::ARP
          Pio::Arp.read raw_data
        when 0x88cc
          Pio::Lldp.read raw_data
        else
          fail 'Failed to parse packet_in data.'
        end
      end
      # rubocop:enable MethodLength
    end
  end

  OpenFlow::Message.factory(PacketIn, OpenFlow::PACKET_IN) do
    def_delegators :body, :buffer_id
    def_delegators :body, :total_len
    def_delegators :body, :in_port
    def_delegators :body, :reason
    def_delegators :body, :data

    attr_accessor :datapath_id
    alias_method :dpid, :datapath_id
    alias_method :dpid=, :datapath_id=

    def parsed_data
      @parsed_data ||= PacketIn::DataParser.read(data)
    end

    def lldp?
      parsed_data.is_a? Lldp
    end

    def source_mac
      parsed_data.source_mac
    end

    def destination_mac
      parsed_data.destination_mac
    end
  end
end
