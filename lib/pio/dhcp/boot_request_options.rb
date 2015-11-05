require 'pio/options'
require 'pio/dhcp/common_options'
require 'pio/dhcp/dhcp_tlv_options'

module Pio
  class Dhcp
    # Options for creating a DHCP message.
    class BootRequestOptions < Pio::Options
      include CommonOptions
      include DhcpTlvOptions

      mandatory_option :source_mac
      mandatory_option :type
      option :destination_mac
      option :requested_ip_address
      option :server_identifier
      option :transaction_id

      def initialize(options)
        validate options
        @options = options
      end

      def to_hash
        {
          destination_mac: destination_mac,
          source_mac: source_mac,
          source_ip_address: QUAD_ZERO_IP_ADDRESS,
          destination_ip_address: BROADCAST_IP_ADDRESS,
          udp_source_port: BOOTPC,
          udp_destination_port: BOOTPS,
          dhcp: dhcp_data
        }
      end

      private

      def dhcp_field_values
        {
          message_type: BootRequest::MESSAGE_TYPE,
          transaction_id: transaction_id,
          client_ip_address: QUAD_ZERO_IP_ADDRESS,
          your_ip_address: QUAD_ZERO_IP_ADDRESS,
          next_server_ip_address: QUAD_ZERO_IP_ADDRESS,
          relay_agent_ip_address: QUAD_ZERO_IP_ADDRESS,
          client_mac_address: source_mac,
          optional_tlvs: options_for_optional_tlv
        }
      end

      def options_for_optional_tlv
        [
          message_type_hash,
          client_identifier_hash,
          requested_ip_address_hash,
          parameters_list_hash,
          dhcp_server_identifier_hash
        ].compact
      end

      def server_identifier
        server_id = @options[:server_identifier]
        IPv4Address.new(server_id) if server_id
      end
    end
  end
end
