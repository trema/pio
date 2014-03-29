# encoding: utf-8

require 'pio/dhcp/const'

module Pio
  class Dhcp
    # DHCP Common Options.
    module CommonOptions
      include Consts

      def dhcp_data
        Dhcp::DhcpField.new(dhcp_field_values)
      end

      def type
        @options[:type]
      end

      def source_mac
        Mac.new(@options[:source_mac])
      end

      def destination_mac
        Mac.new(@options[:destination_mac] || BROADCAST_MAC_ADDRESS)
      end

      def ip_source_address
        IPv4Address.new(@options[:ip_source_address])
      end

      def ip_destination_address
        IPv4Address.new(@options[:ip_destination_address])
      end

      def server_identifier
        IPv4Address.new(
          @options[:server_identifier] || ip_source_address
        )
      end

      def subnet_mask
        subnet = @options[:subnet_mask]
        IPv4Address.new(subnet) if subnet
      end

      def transaction_id
        @options[:transaction_id]
      end

      def renewal_time_value
        @options[:renewal_time_value]
      end

      def rebinding_time_value
        @options[:rebinding_time_value]
      end

      def ip_address_lease_time
        @options[:ip_address_lease_time]
      end

      def requested_ip_address
        IPv4Address.new(
          @options[:requested_ip_address] || QUAD_ZERO_IP_ADDRESS
        )
      end
    end
  end
end
