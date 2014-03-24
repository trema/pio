# -*- coding: utf-8 -*-

require 'pio/dhcp/boot_request'

module Pio
  class Dhcp
    # Dhcp Discover packet generator
    class Discover < BootRequest
      TYPE = 1

      def requested_ip_address_hash
        {
          tlv_type: REQUESTED_IP_ADDRESS_TLV,
          tlv_info_length: QUAD_ZERO_IP_ADDRESS.length,
          tlv_value: QUAD_ZERO_IP_ADDRESS
        }
      end

      def request_option
        []
      end
    end
  end
end
