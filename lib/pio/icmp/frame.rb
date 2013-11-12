# -*- coding: utf-8 -*-
require 'pio/type/ethernet_header'
require 'pio/type/ipv4_header'

module Pio
  class Icmp
    # Icmp frame parser.
    class Frame < BinData::Record
      extend Type::EthernetHeader
      extend Type::IPv4Header

      endian :big

      ethernet_header :ether_type => 0x0800
      ipv4_header :ip_protocol => 1,
                  :ip_header_checksum => lambda { get_ip_checksum },
                  :ip_total_length => lambda { get_ip_total_length }
      uint8 :icmp_type
      uint8 :icmp_code, :initial_value => 0
      uint16 :icmp_checksum, :value => lambda { get_icmp_checksum }
      uint16 :icmp_identifier
      uint16 :icmp_sequence_number
      string :echo_data,
             :initial_value => 'DEADBEEF',
             :read_length => lambda { get_read_length }

      def message_type
        icmp_type
      end

      def get_read_length
        ip_total_length - (ip_header_length * 4 + 8)
      end

      def get_ip_total_length
        icmpsize = (ip_header_length * 4) + (8 + echo_data.bytesize)
        if icmpsize < 36
          icmpsize + (36 - icmpsize)
        else
          icmpsize
        end
      end

      def get_icmp_checksum
        ~((icmp_sum & 0xffff) + (icmp_sum >> 16)) & 0xffff
      end

      def icmp_sum
        icmp_2bytewise_slices.reduce(0) do |acc, each|
          acc + each
        end
      end

      def get_ip_checksum
        ~((ip_sum & 0xffff) + (ip_sum >> 16)) & 0xffff
      end

      def ip_sum
        ipv4_header_2bytewise_slices.reduce(0) do |acc, each|
          acc + each
        end
      end

      def icmp_2bytewise_slices
        [
         icmp_type * 0x100 + icmp_code,
         icmp_identifier,
         icmp_sequence_number,
         *echo_data.unpack('n*')
        ]
      end

      def ipv4_header_2bytewise_slices
        [
         ipversion_ipheaderlength_iptypeofservice, ip_total_length,
         ip_identifier, ipflag_ipfragment,
         ipttl_ipproto,
         ip_source_address_upper,
         ip_source_address_lower,
         ip_destination_address_upper,
         ip_destination_address_lower
        ]
      end

      def ip_source_address_upper
        ip_source_address.get.to_i >> 16
      end

      def ip_source_address_lower
        ip_source_address.get.to_i & 0xffff
      end

      def ip_destination_address_upper
        ip_destination_address.get.to_i >> 16
      end

      def ip_destination_address_lower
        ip_destination_address.get.to_i & 0xffff
      end

      def ipversion_ipheaderlength_iptypeofservice
        ip_version << 12 | ip_header_length << 8 | ip_type_of_service
      end

      def ipflag_ipfragment
        ip_flag << 13 | ip_fragment
      end

      def ipttl_ipproto
        ip_ttl << 8 | ip_protocol
      end

      def to_binary
        if num_bytes < 64
          to_binary_s + "\000" * (64 - num_bytes)
        else
          to_binary_s
        end
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
