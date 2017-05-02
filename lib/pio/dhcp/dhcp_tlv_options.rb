# frozen_string_literal: true

require 'pio/dhcp/common_options'

module Pio
  class Dhcp
    # DHCP TLV Methods.
    module DhcpTlvOptions
      include CommonOptions

      def message_type_hash
        {
          tlv_type: Dhcp::MESSAGE_TYPE_TLV,
          tlv_info_length: 1,
          tlv_value: type
        }
      end

      def client_identifier_hash
        {
          tlv_type: Dhcp::CLIENT_IDENTIFIER_TLV,
          tlv_info_length: 7,
          tlv_value: source_mac
        }
      end

      def requested_ip_address_hash
        {
          tlv_type: Dhcp::REQUESTED_IP_ADDRESS_TLV,
          tlv_info_length: 4,
          tlv_value: requested_ip_address
        }
      end

      def dhcp_server_identifier_hash
        if server_identifier
          {
            tlv_type: Dhcp::SERVER_IDENTIFIER_TLV,
            tlv_info_length: 4,
            tlv_value: server_identifier
          }
        end
      end

      def parameters_list_hash
        {
          tlv_type: Dhcp::PARAMETERS_LIST_TLV,
          tlv_info_length: Dhcp::PARAMETER_REQUEST_LIST.length,
          tlv_value: Dhcp::PARAMETER_REQUEST_LIST
        }
      end

      def renewal_time_value_hash
        if renewal_time_value
          {
            tlv_type: Dhcp::RENEWAL_TIME_VALUE_TLV,
            tlv_info_length: 4,
            tlv_value: renewal_time_value
          }
        end
      end

      def rebinding_time_value_hash
        if rebinding_time_value
          {
            tlv_type: Dhcp::REBINDING_TIME_VALUE_TLV,
            tlv_info_length: 4,
            tlv_value: rebinding_time_value
          }
        end
      end

      def ip_address_lease_time_hash
        {
          tlv_type: Dhcp::IP_ADDRESS_LEASE_TIME_TLV,
          tlv_info_length: 4,
          tlv_value: ip_address_lease_time
        }
      end

      def subnet_mask_hash
        if subnet_mask
          {
            tlv_type: Dhcp::SUBNET_MASK_TLV,
            tlv_info_length: 4,
            tlv_value: subnet_mask
          }
        end
      end
    end
  end
end
