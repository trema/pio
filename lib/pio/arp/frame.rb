# -*- coding: utf-8 -*-
require 'bindata'
require 'pio/type/ethernet_header'
require 'pio/type/ip_address'
require 'pio/type/mac_address'

module Pio
  class Arp
    # ARP frame parser.
    class Frame < BinData::Record
      extend Type::EthernetHeader

      endian :big

      ethernet_header ether_type: 0x0806
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

      def to_binary
        to_binary_s + "\000" * (64 - num_bytes)
      end
    end
  end
end
