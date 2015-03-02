require 'pio/payload'
require 'pio/type/ip_address'

module Pio
  # IP Version 4 Header Format
  module IPv4Header
    include Payload

    IP_PROTOCOL_ICMP = 1
    IP_PROTOCOL_UDP = 17

    # rubocop:disable MethodLength
    # rubocop:disable AbcSize
    # This method smells of :reek:TooManyStatements
    def self.included(klass)
      def klass.ipv4_header(options = {})
        bit4 :ip_version, value: 0x4
        bit4 :ip_header_length, initial_value: 0x5
        uint8 :ip_type_of_service, initial_value: 0
        uint16be :ip_total_length, initial_value: :calculate_ip_length
        uint16be :ip_identifier, initial_value: 0
        bit3 :ip_flag, initial_value: 0
        bit13 :ip_fragment, initial_value: 0
        uint8 :ip_ttl, initial_value: 128
        uint8 :ip_protocol, initial_value: options[:ip_protocol] || 0
        uint16be :ip_header_checksum, initial_value: :calculate_ip_checksum
        ip_address :ip_source_address
        ip_address :ip_destination_address
        string :ip_option, read_length: :ip_option_length
      end
    end
    # rubocop:enable MethodLength
    # rubocop:enable AbcSize

    private

    def calculate_ip_length
      ip_header_length * 4 + ip_payload_binary.length
    end

    # rubocop:disable AbcSize
    def calculate_ip_checksum
      sum = [ip_version << 12 | ip_header_length << 8 | ip_type_of_service,
             ip_total_length,
             ip_identifier,
             ip_flag << 13 | ip_fragment,
             ip_ttl << 8 | ip_protocol,
             ip_source_address >> 16,
             ip_source_address & 0xffff,
             ip_destination_address >> 16,
             ip_destination_address & 0xffff].reduce(:+)
      ~((sum & 0xffff) + (sum >> 16)) & 0xffff
    end
    # rubocop:enable AbcSize

    def ip_payload_binary
      binary_after(:ip_option)
    end

    def ip_option_length
      20 - ip_header_length * 4
    end
  end
end
