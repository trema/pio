require 'pio/ethernet_frame'
require 'pio/ethernet_header'
require 'pio/ipv4_header'

module Pio
  # Raw data parser.
  class Parser
    # IPv4 packet parser
    class IPv4Packet < BinData::Record
      include Ethernet
      include IPv4

      endian :big

      ethernet_header ether_type: Ethernet::Type::IPV4
      ipv4_header

      uint16 :transport_source_port
      uint16 :transport_destination_port
      rest :rest
    end

    # rubocop:disable MethodLength
    def self.read(raw_data)
      ethernet_frame = EthernetFrame.read(raw_data)
      case ethernet_frame.ether_type
      when Ethernet::Type::IPV4, Ethernet::Type::VLAN
        IPv4Packet.read raw_data
      when Ethernet::Type::ARP
        Pio::Arp.read raw_data
      when Ethernet::Type::LLDP
        Pio::Lldp.read raw_data
      else
        ethernet_frame
      end
    end
    # rubocop:enable MethodLength
  end
end
