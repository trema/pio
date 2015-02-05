require 'pio/type/ip_address'

module Pio
  module Type
    # IP Version 4 Header Format
    module IPv4Header
      # This method smells of :reek:TooManyStatements
      # rubocop:disable MethodLength
      # rubocop:disable AbcSize
      def ipv4_header(options = {})
        class_eval do
          bit4 :ip_version, initial_value: 0x4
          bit4 :ip_header_length, initial_value: 0x5
          uint8 :ip_type_of_service, initial_value: 0
          uint16be :ip_total_length,
                   initial_value: options[:ip_total_length] || 0
          uint16be :ip_identifier, initial_value: 0
          bit3 :ip_flag, initial_value: 0
          bit13 :ip_fragment, initial_value: 0
          uint8 :ip_ttl, initial_value: 128
          uint8 :ip_protocol, initial_value: options[:ip_protocol] || 0
          uint16be :ip_header_checksum,
                   initial_value: options[:ip_header_checksum] || 0
          ip_address :ip_source_address
          ip_address :ip_destination_address
          string :option, read_length: -> { 20 - ip_header_length * 4 }
        end
      end
      # rubocop:enable AbcSize
      # rubocop:enable MethodLength
    end
  end
end
