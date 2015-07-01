require 'pio/ethernet_header'
require 'pio/ipv4_header'

module Pio
  # Raw data parser.
  class Parser
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

      ethernet_header ether_type: EtherType::IPV4
      ipv4_header

      uint16 :transport_source_port
      uint16 :transport_destination_port
      rest :rest
    end

    # rubocop:disable MethodLength
    def self.read(raw_data)
      ethernet_header = EtherTypeParser.read(raw_data)
      case ethernet_header.ether_type
      when EthernetHeader::EtherType::IPV4, EthernetHeader::EtherType::VLAN
        IPv4Packet.read raw_data
      when EthernetHeader::EtherType::ARP
        Pio::Arp.read raw_data
      when EthernetHeader::EtherType::LLDP
        Pio::Lldp.read raw_data
      else
        fail 'Failed to parse packet_in data.'
      end
    end
    # rubocop:enable MethodLength
  end
end
