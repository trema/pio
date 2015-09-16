require 'bindata'
require 'pio/ethernet_header'
require 'pio/ipv4_header'

module Pio
  # Icmp parser and generator.
  class Icmp
    # Icmp parser.
    class Format < BinData::Record
      MINIMUM_IP_PACKET_LENGTH = 50

      include EthernetHeader
      include IPv4Header

      endian :big

      ethernet_header ether_type: EtherType::IPV4
      ipv4_header ip_protocol: ProtocolNumber::ICMP
      uint8 :icmp_type
      uint8 :icmp_code, initial_value: 0
      uint16 :icmp_checksum, value: :calculate_icmp_checksum
      uint16 :icmp_identifier
      uint16 :icmp_sequence_number
      string :echo_data, read_length: :echo_data_read_length
      string :padding, read_length: 0, initial_value: :icmp_padding_length

      def message_type
        icmp_type
      end

      alias_method :to_binary, :to_binary_s

      private

      def calculate_icmp_checksum
        sum = [icmp_type * 0x100 + icmp_code,
               icmp_identifier,
               icmp_sequence_number,
               *echo_data.unpack('n*')].inject(:+)
        ~((sum & 0xffff) + (sum >> 16)) & 0xffff
      end

      def echo_data_read_length
        ip_total_length - (ip_header_length * 4) - 8
      end

      def icmp_padding_length
        length = MINIMUM_IP_PACKET_LENGTH -
                 (ip_header_length * 4) - 8 - echo_data.length
        length > 0 ? "\x00" * length : ''
      end
    end
  end
end
