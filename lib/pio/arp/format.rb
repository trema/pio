require 'bindata'
require 'pio/ethernet_header'
require 'pio/type/ip_address'
require 'pio/type/mac_address'

module Pio
  # ARP parser and generator.
  class Arp
    # ARP parser.
    class Format < BinData::Record
      include EthernetHeader

      endian :big

      ethernet_header ether_type: EtherType::ARP
      uint16 :hardware_type, value: 1
      uint16 :protocol_type, value: 0x0800
      uint8 :hardware_length, value: 6
      uint8 :protocol_length, value: 4
      uint16 :operation
      mac_address :sender_hardware_address
      ip_address :sender_protocol_address
      mac_address :target_hardware_address
      ip_address :target_protocol_address

      def message_type
        operation
      end

      # rubocop:disable MethodLength
      def to_exact_match(in_port)
        match_options = {
          in_port: in_port,
          source_mac_address: source_mac,
          destination_mac_address: destination_mac,
          vlan_vid: vlan_vid,
          vlan_priority: vlan_pcp,
          ether_type: ether_type,
          tos: 0,
          ip_protocol: operation,
          source_ip_address: sender_protocol_address,
          destination_ip_address: target_protocol_address,
          transport_source_port: 0,
          transport_destination_port: 0
        }
        Pio::OpenFlow10::Match.new(match_options)
      end
      # rubocop:enable MethodLength

      def to_binary
        to_binary_s + "\000" * (64 - num_bytes)
      end
    end
  end
end
