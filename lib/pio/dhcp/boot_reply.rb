# encoding: utf-8

require 'pio/dhcp/message'
require 'pio/dhcp/const'

module Pio
  class Dhcp
    # DHCP Reply Frame Base Class
    class BootReply < Message
      include Consts

      MESSAGE_TYPE = 2

      private

      def mandatory_options
        [
         :destination_mac,
         :source_mac,
         :ip_destination_address,
         :ip_source_address
        ]
      end

      def default_options
        {
          destination_mac: macda,
          source_mac: macsa,
          ip_destination_address: ipv4_daddr,
          ip_source_address: ipv4_saddr,
          udp_src_port: BOOTPS,
          udp_dst_port: BOOTPC,
          dhcp: dhcp_data
        }
      end

      def options_for_dhcp
        {
          message_type: self.class::MESSAGE_TYPE,
          transaction_id: xid,
          client_ip_address: QUAD_ZERO_IP_ADDRESS,
          your_ip_address: ipv4_daddr,
          next_server_ip_address: QUAD_ZERO_IP_ADDRESS,
          relay_agent_ip_address: QUAD_ZERO_IP_ADDRESS,
          client_mac_address: macsa,
          optional_tlvs: options_for_optional_tlv
        }
      end

      def options_for_optional_tlv
        [
          message_type_hash,
          renewal_time_value_hash,
          rebinding_time_value_hash,
          ip_address_lease_time_hash,
          dhcp_server_identifier_hash,
          subnet_mask_hash
        ].concat(reply_option)
      end

      def user_options
        @options.merge(
          destination_mac: macda,
          source_mac: macsa,
          ip_destination_address: ipv4_daddr,
          ip_source_address: ipv4_saddr
        )
      end
    end
  end
end
