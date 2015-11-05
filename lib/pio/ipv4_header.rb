require 'pio/payload'
require 'pio/type/ip_address'

module Pio
  # IP Version 4 Header Format
  module IPv4Header
    # Internet protocol numbers for ipv4_header.ip_protocol
    module ProtocolNumber
      ICMP = 1
      UDP = 17
    end

    include Payload

    # rubocop:disable MethodLength
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
        ip_address :source_ip_address
        ip_address :destination_ip_address
        string :ip_option, read_length: :ip_option_length
      end
    end
    # rubocop:enable MethodLength

    # rubocop:disable MethodLength
    def to_exact_match(in_port)
      match_options = {
        in_port: in_port,
        source_mac_address: source_mac,
        destination_mac_address: destination_mac,
        vlan_vid: vlan_vid,
        vlan_priority: vlan_pcp,
        ether_type: ether_type,
        tos: ip_type_of_service,
        ip_protocol: ip_protocol,
        source_ip_address: source_ip_address,
        destination_ip_address: destination_ip_address,
        transport_source_port: transport_source_port,
        transport_destination_port: transport_destination_port
      }
      Pio::OpenFlow10::Match.new match_options
    end
    # rubocop:enable MethodLength

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
             source_ip_address >> 16,
             source_ip_address & 0xffff,
             destination_ip_address >> 16,
             destination_ip_address & 0xffff].reduce(:+)
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
