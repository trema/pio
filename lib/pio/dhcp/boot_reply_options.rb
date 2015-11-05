require 'pio/options'
require 'pio/dhcp/common_options'
require 'pio/dhcp/dhcp_tlv_options'

module Pio
  class Dhcp
    # Options for creating a DHCP message.
    class BootReplyOptions < Pio::Options
      include CommonOptions
      include DhcpTlvOptions

      mandatory_option :source_mac
      mandatory_option :destination_mac
      mandatory_option :source_ip_address
      mandatory_option :destination_ip_address
      mandatory_option :type
      option :subnet_mask
      option :renewal_time_value
      option :rebinding_time_value
      option :ip_address_lease_time
      option :server_identifier
      option :transaction_id

      def initialize(options)
        @options = options
      end

      def to_hash
        {
          destination_mac: destination_mac,
          source_mac: source_mac,
          destination_ip_address: destination_ip_address,
          source_ip_address: source_ip_address,
          udp_source_port: BOOTPS,
          udp_destination_port: BOOTPC,
          dhcp: dhcp_data
        }
      end

      private

      def dhcp_field_values
        {
          message_type: BootReply::MESSAGE_TYPE,
          transaction_id: transaction_id,
          client_ip_address: QUAD_ZERO_IP_ADDRESS,
          your_ip_address: destination_ip_address,
          next_server_ip_address: QUAD_ZERO_IP_ADDRESS,
          relay_agent_ip_address: QUAD_ZERO_IP_ADDRESS,
          client_mac_address: source_mac,
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
        ].compact
      end

      def server_identifier
        IPv4Address.new(
          @options[:server_identifier] || source_ip_address
        )
      end
    end
  end
end
