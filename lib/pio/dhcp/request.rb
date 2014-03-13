# -*- coding: utf-8 -*-

require 'pio/dhcp/boot_request'
require 'pio/ipv4_address'
require 'pio/dhcp/const'

module Pio
  class Dhcp
    # Dhcp Request packet generator
    class Request < BootRequest
      include Consts

      TYPE = 3

      private

      def requested_ip_address_hash
        {
          tlv_type: REQUESTED_IP_ADDRESS_TLV,
          tlv_info_length: requested_address.length,
          tlv_value: requested_address
        }
      end

      def request_option
        [
          dhcp_server_identifier_hash
        ]
      end

      def dhcp_server_identifier_hash
        {
          tlv_type: SERVER_IDENTIFIER_TLV,
          tlv_info_length: server_identifier.length,
          tlv_value: server_identifier
        }
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
