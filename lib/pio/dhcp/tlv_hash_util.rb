# -*- coding: utf-8 -*-

require 'pio/ipv4_address'
require 'pio/mac'

module Pio
  class Dhcp
    # DHCP TLV FIELD UTILITY
    module TlvHashUtil
      include Consts

      private

      def dhcp_data
        Dhcp::DhcpField.new(options_for_dhcp)
      end

      def server_identifier
        IPv4Address.new(@options[:server_identifier_tlv]).to_a
      end

      def requested_address
        IPv4Address.new(@options[:requested_ip_address_tlv]).to_a
      end

      def macsa
        Mac.new(@options[:source_mac])
      end

      def macda
        Mac.new(@options[:destination_mac])
      end

      def ipv4_saddr
        IPv4Address.new(@options[:ip_source_address])
      end

      def ipv4_daddr
        IPv4Address.new(@options[:ip_destination_address])
      end

      def xid
        @options[:transaction_id]
      end

      def ren_time_val
        @options[:renewal_time_value_tlv]
      end

      def reb_time_val
        @options[:rebinding_time_value_tlv]
      end

      def ip_lease_time_val
        @options[:ip_address_lease_time_tlv]
      end

      def subnet_mask
        IPv4Address.new(@options[:subnet_mask_tlv]).to_a
      end

      def message_type_hash
        {
          tlv_type: MESSAGE_TYPE_TLV,
          tlv_info_length: 1,
          tlv_value: self.class::TYPE
        }
      end

      def renewal_time_value_hash
        {
          tlv_type: RENEWAL_TIME_VALUE_TLV,
          tlv_info_length: 4,
          tlv_value: ren_time_val
        }
      end

      def dhcp_server_identifier_hash
        {
          tlv_type: SERVER_IDENTIFIER_TLV,
          tlv_info_length: 4,
          tlv_value: server_identifier
        }
      end

      def rebinding_time_value_hash
        {
          tlv_type: REBINDING_TIME_VALUE_TLV,
          tlv_info_length: 4,
          tlv_value: reb_time_val
        }
      end

      def ip_address_lease_time_hash
        {
          tlv_type: IP_ADDRESS_LEASE_TIME_TLV,
          tlv_info_length: 4,
          tlv_value: ip_lease_time_val
        }
      end

      def dhcp_server_identifier_hash
        {
          tlv_type: SERVER_IDENTIFIER_TLV,
          tlv_info_length: 4,
          tlv_value: ipv4_saddr
        }
      end

      def subnet_mask_hash
        {
          tlv_type: SUBNET_MASK_TLV,
          tlv_info_length: 4,
          tlv_value: subnet_mask
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
    end
  end
end
