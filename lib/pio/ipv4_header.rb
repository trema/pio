# frozen_string_literal: true

require 'pio/instance_inspector'
require 'pio/monkey_patch/bindata_string'
require 'pio/payload'
require 'pio/ruby_dumper'
require 'pio/type/ip_address'

module Pio
  # IP Version 4 Header Format
  module IPv4
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
        vlan_vid: vlan? ? vlan_vid : 0xffff,
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

    def ip_header_length_in_bytes
      ip_header_length * 4
    end

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

  # IPv4 header generator/parser
  class IPv4Header < BinData::Record
    include IPv4
    include InstanceInspector
    include RubyDumper

    ipv4_header

    # rubocop:disable LineLength
    def self.inspect
      'IPv4Header(ip_version: bit4, ip_header_length: bit4, ip_type_of_service: uint8, ip_total_length: uint16, ip_identifier: uint16, ip_flag: bit3, ip_fragment: bit13, ip_ttl: uint8, ip_protocol: uint8, ip_header_checksum: uint16, source_ip_address: ip_address, destination_ip_address: ip_address, ip_option: string)'
    end
    # rubocop:enable LineLength
  end
end
