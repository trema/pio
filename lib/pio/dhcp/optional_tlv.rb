# encoding: utf-8

require 'pio/dhcp/const'
require 'pio/dhcp/type/dhcp_param_list'
require 'pio/dhcp/type/dhcp_client_id'
require 'pio/dhcp/type/dhcp_string'
require 'pio/type/ip_address'

module Pio
  class Dhcp
    # DHCP Optional TLV
    class OptionalTlv < BinData::Record
      include Consts
      endian :big

      bit8 :tlv_type
      bit8 :tlv_info_length,
           onlyif: -> { !(end_of_dhcpdu?) }
      choice  :tlv_value,
              onlyif: -> { !(end_of_dhcpdu?) },
              selection: :chooser do
        uint8 MESSAGE_TYPE_TLV
        ip_address SERVER_IDENTIFIER_TLV
        uint32be RENEWAL_TIME_VALUE_TLV
        uint32be REBINDING_TIME_VALUE_TLV
        uint32be IP_ADDRESS_LEASE_TIME_TLV
        ip_address SUBNET_MASK_TLV
        ip_address REQUESTED_IP_ADDRESS_TLV
        client_id CLIENT_IDENTIFIER_TLV
        parameter_list PARAMETERS_LIST_TLV
        dhcp_string DEFAULT
      end

      def end_of_dhcptlv?
        tlv_type == END_OF_TLV
      end

      def chooser
        if valid_optional_tlv?
          tlv_type
        else
          DEFAULT
        end
      end

      def end_of_dhcpdu?
        tlv_type == END_OF_TLV
      end

      private

      def valid_optional_tlv?
        optional_tlv? || end_of_dhcptlv?
      end

      # rubocop:disable MethodLength
      def optional_tlv?
        [
          MESSAGE_TYPE_TLV,
          SERVER_IDENTIFIER_TLV,
          CLIENT_IDENTIFIER_TLV,
          RENEWAL_TIME_VALUE_TLV,
          REBINDING_TIME_VALUE_TLV,
          REQUESTED_IP_ADDRESS_TLV,
          PARAMETERS_LIST_TLV,
          IP_ADDRESS_LEASE_TIME_TLV,
          SUBNET_MASK_TLV
        ].include?(tlv_type)
      end
      # rubocop:enable MethodLength
    end
  end
end
