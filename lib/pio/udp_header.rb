require 'pio/payload'

module Pio
  # UDP Header Format.
  module UdpHeader
    include Payload

    # Pseudo UDP header
    class PseudoUdpHeader < BinData::Record
      endian :big
      ip_address :source_ip_address
      ip_address :destination_ip_address
      uint8 :padding
      uint8 :ip_protocol, value: IPv4Header::ProtocolNumber::UDP
      uint16 :udp_length
    end

    def self.included(klass)
      def klass.udp_header
        uint16 :udp_source_port
        uint16 :udp_destination_port
        uint16 :udp_length, initial_value: :calculate_udp_length
        uint16 :udp_checksum, initial_value: :calculate_udp_checksum
      end
    end

    private

    def calculate_udp_length
      8 + udp_payload_binary.length
    end

    def calculate_udp_checksum
      sum = [*pseudo_udp_header.unpack('n*'),
             udp_source_port,
             udp_destination_port,
             udp_length,
             *udp_payload_multiple_of_2octets.unpack('n*')].inject(:+)
      ~((sum & 0xffff) + (sum >> 16)) & 0xffff
    end

    def udp_payload_binary
      binary_after :udp_checksum
    end

    def pseudo_udp_header
      PseudoUdpHeader.new(source_ip_address: source_ip_address,
                          destination_ip_address: destination_ip_address,
                          udp_length: udp_length).to_binary_s
    end

    def udp_payload_multiple_of_2octets
      udp_payload_binary + '\x00' * (udp_payload_binary.length.even? ? 0 : 1)
    end
  end
end
