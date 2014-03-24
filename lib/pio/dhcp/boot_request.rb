# -*- coding: utf-8 -*-

require 'pio/dhcp/message'
require 'pio/dhcp/const'

module Pio
  class Dhcp
    # DHCP Request Frame Base Class
    class BootRequest < Message
      include Consts

      MESSAGE_TYPE = 1

      private

      PARAMETER_REQUEST_LIST = [
        SUBNET_MASK_TLV,
        ROUTER_TLV,
        DNS_TLV,
        NTP_SERVERS_TLV
      ]

      def mandatory_options
        [
         :source_mac
        ]
      end

      def default_options
        {
          destination_mac: BROADCAST_MAC_ADDRESS,
          ip_destination_address: BROADCAST_IP_ADDRESS,
          ip_source_address: QUAD_ZERO_IP_ADDRESS,
          udp_src_port: BOOTPC,
          udp_dst_port: BOOTPS,
          dhcp: dhcp_data
        }
      end

      def options_for_dhcp
        {
          message_type: BootRequest::MESSAGE_TYPE,
          transaction_id: xid,
          client_ip_address: QUAD_ZERO_IP_ADDRESS,
          your_ip_address: QUAD_ZERO_IP_ADDRESS,
          next_server_ip_address: QUAD_ZERO_IP_ADDRESS,
          relay_agent_ip_address: QUAD_ZERO_IP_ADDRESS,
          client_mac_address: macsa,
          optional_tlvs: options_for_optional_tlv
        }
      end

      def options_for_optional_tlv
        [
          message_type_hash,
          client_identifier_hash,
          requested_ip_address_hash,
          parameters_list_hash
        ].concat(request_option)
      end

      def message_type_hash
        {
          tlv_type: MESSAGE_TYPE_TLV,
          tlv_info_length: 1,
          tlv_value: self.class::TYPE
        }
      end

      def client_identifier_hash
        {
          tlv_type: CLIENT_IDENTIFIER_TLV,
          tlv_info_length: 7,
          tlv_value: macsa
        }
      end

      def parameters_list_hash
        {
          tlv_type: PARAMETERS_LIST_TLV,
          tlv_info_length: PARAMETER_REQUEST_LIST.length,
          tlv_value: PARAMETER_REQUEST_LIST
        }
      end

      def user_options
        @options.merge({})
      end
    end
  end
end
