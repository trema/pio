require 'pio/dhcp/parameter_list'
require 'pio/dhcp/client_id'
require 'pio/type/ip_address'

module Pio
  # Dhcp parser and generator.
  class Dhcp
    # DHCP Optional TLV
    class OptionalTlv < BinData::Record
      DEFAULT = 'default'

      endian :big

      bit8 :tlv_type
      bit8 :tlv_info_length,
           onlyif: -> { !(end_of_dhcpdu?) }
      choice :tlv_value,
             onlyif: -> { !(end_of_dhcpdu?) },
             selection: :chooser do
        uint8 Dhcp::MESSAGE_TYPE_TLV
        ip_address Dhcp::SERVER_IDENTIFIER_TLV
        uint32be Dhcp::RENEWAL_TIME_VALUE_TLV
        uint32be Dhcp::REBINDING_TIME_VALUE_TLV
        uint32be Dhcp::IP_ADDRESS_LEASE_TIME_TLV
        ip_address Dhcp::SUBNET_MASK_TLV
        ip_address Dhcp::REQUESTED_IP_ADDRESS_TLV
        client_id Dhcp::CLIENT_IDENTIFIER_TLV
        parameter_list Dhcp::PARAMETERS_LIST_TLV
        string DEFAULT
      end

      def end_of_dhcptlv?
        tlv_type == Dhcp::END_OF_TLV
      end

      def chooser
        if valid_optional_tlv?
          tlv_type
        else
          DEFAULT
        end
      end

      def end_of_dhcpdu?
        tlv_type == Dhcp::END_OF_TLV
      end

      private

      def valid_optional_tlv?
        optional_tlv? || end_of_dhcptlv?
      end

      # rubocop:disable MethodLength
      def optional_tlv?
        [
          Dhcp::MESSAGE_TYPE_TLV,
          Dhcp::SERVER_IDENTIFIER_TLV,
          Dhcp::CLIENT_IDENTIFIER_TLV,
          Dhcp::RENEWAL_TIME_VALUE_TLV,
          Dhcp::REBINDING_TIME_VALUE_TLV,
          Dhcp::REQUESTED_IP_ADDRESS_TLV,
          Dhcp::PARAMETERS_LIST_TLV,
          Dhcp::IP_ADDRESS_LEASE_TIME_TLV,
          Dhcp::SUBNET_MASK_TLV
        ].include?(tlv_type)
      end
      # rubocop:enable MethodLength
    end
  end
end
