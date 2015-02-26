require 'bindata'

module Pio
  module Type
    # UDP Header Format.
    module UdpHeader
      # Pseudo UDP header
      class PseudoUdpHeader < BinData::Record
        endian :big

        ip_address :ip_source_address
        ip_address :ip_destination_address
        uint8 :padding
        uint8 :ip_protocol, value: 17
        uint16 :udp_length
      end

      # rubocop:disable MethodLength
      # rubocop:disable AbcSize
      def udp_header
        class_eval do
          uint16 :udp_source_port
          uint16 :udp_destination_port
          uint16(:udp_length,
                 value: lambda do
                   8 + udp_payload.length + udp_payload_padding_length
                 end)
          uint16 :udp_checksum, initial_value: :calculate_udp_checksum

          private

          def calculate_udp_checksum
            sum = [*pseudo_udp_header.unpack('n*'),
                   udp_source_port,
                   udp_destination_port,
                   udp_length,
                   *udp_payload_multiple_of_2octets.unpack('n*')].inject(:+)
            ~((sum & 0xffff) + (sum >> 16)) & 0xffff
          end

          def pseudo_udp_header
            PseudoUdpHeader.new(ip_source_address: ip_source_address,
                                ip_destination_address: ip_destination_address,
                                udp_length: udp_length).to_binary_s
          end

          def udp_payload_multiple_of_2octets
            udp_payload + '\x00' * udp_payload_padding_length
          end

          def udp_payload_padding_length
            udp_payload.length.even? ? 0 : 1
          end
        end
      end
      # rubocop:enable AbcSize
      # rubocop:enable MethodLength
    end
  end
end
