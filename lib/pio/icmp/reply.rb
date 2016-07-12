require 'pio/icmp/message'
require 'pio/icmp/options'
require 'pio/instance_inspector'
require 'pio/mac'

module Pio
  class Icmp
    # ICMP Reply packet generator
    class Reply < Message
      include InstanceInspector

      TYPE = 0
      public_class_method :new

      # rubocop:disable LineLength
      def self.inspect
        'Icmp::Reply(destination_mac: mac_address, source_mac: mac_address, ether_type: uint16, vlan_pcp: bit3, vlan_cfi: bit1, vlan_vid: bit12, ip_version: bit4, ip_header_length: bit4, ip_type_of_service: uint8, ip_total_length: uint16, ip_identifier: uint16, ip_flag: bit3, ip_fragment: bit13, ip_ttl: uint8, ip_protocol: uint8, ip_header_checksum: uint16, source_ip_address: ip_address, destination_ip_address: ip_address, ip_option: string, icmp_type: uint8, icmp_code: uint8, icmp_checksum: uint16, icmp_identifier: uint16, icmp_sequence_number: uint16, echo_data: string)'
      end
      # rubocop:enable LineLength

      # User options for creating an ICMP Reply.
      class Options < Pio::Icmp::Options
        mandatory_option :source_mac
        mandatory_option :destination_mac
        mandatory_option :source_ip_address
        mandatory_option :destination_ip_address
        mandatory_option :identifier
        mandatory_option :sequence_number
        option :echo_data

        # rubocop:disable MethodLength
        # rubocop:disable AbcSize
        def initialize(options)
          validate options
          @type = TYPE

          @source_mac = Mac.new(options[:source_mac]).freeze
          @destination_mac = Mac.new(options[:destination_mac]).freeze
          @source_ip_address =
            IPv4Address.new(options[:source_ip_address]).freeze
          @destination_ip_address =
            IPv4Address.new(options[:destination_ip_address]).freeze
          @identifier = options[:identifier]
          @sequence_number = options[:sequence_number]
          @echo_data = options[:echo_data] || ''
        end
        # rubocop:enable AbcSize
        # rubocop:enable MethodLength
      end
    end
  end
end
