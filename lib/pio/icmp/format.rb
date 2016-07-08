require 'pio/ethernet_header'
require 'pio/ipv4_header'
require 'pio/monkey_patch/bindata_record'

module Pio
  # ICMP parser and generator
  class Icmp
    # ICMP format
    class Format < BinData::Record
      include Ethernet
      include IPv4

      endian :big

      ethernet_header ether_type: Ethernet::Type::IPV4
      ipv4_header ip_protocol: ProtocolNumber::ICMP
      uint8 :icmp_type
      uint8 :icmp_code, initial_value: 0
      uint16 :icmp_checksum, value: :calculate_icmp_checksum
      uint16 :icmp_identifier
      uint16 :icmp_sequence_number
      string :echo_data, read_length: :echo_data_length
      string :padding, length: :padding_length

      private

      def icmp_header_length
        8
      end

      def calculate_icmp_checksum
        sum = [icmp_type * 0x100 + icmp_code,
               icmp_identifier,
               icmp_sequence_number,
               *echo_data.unpack('n*')].inject(:+)
        ~((sum & 0xffff) + (sum >> 16)) & 0xffff
      end

      def echo_data_length
        ip_total_length - ip_header_length_in_bytes - icmp_header_length
      end

      def padding_length
        tmp = Ethernet::MINIMUM_FRAME_SIZE -
              ethernet_header_length - ip_header_length_in_bytes -
              icmp_header_length - echo_data.length
        tmp > 0 ? tmp : 0
      end
    end
  end
end
