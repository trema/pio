# encoding: utf-8

require 'pio/dhcp/frame'
require 'pio/dhcp/tlv_hash_util'
require 'pio/message_util'
require 'forwardable'
require 'pp'

module Pio
  class Dhcp
    # Base class of Dhcp Packet Generator and Parser.
    class Message
      extend Forwardable
      include MessageUtil
      include TlvHashUtil

      def initialize(options)
        @options = options
        @frame = Dhcp::Frame.new(option_hash)
      end

      def_delegators :@frame, :destination_mac
      def_delegators :@frame, :source_mac
      def_delegators :@frame, :ether_type
      def_delegators :@frame, :ip_version
      def_delegators :@frame, :ip_header_length
      def_delegators :@frame, :ip_type_of_service
      def_delegators :@frame, :ip_total_length
      def_delegators :@frame, :ip_identifier
      def_delegators :@frame, :ip_flag
      def_delegators :@frame, :ip_fragment
      def_delegators :@frame, :ip_ttl
      def_delegators :@frame, :ip_protocol
      def_delegators :@frame, :ip_header_checksum
      def_delegators :@frame, :ip_source_address
      def_delegators :@frame, :ip_destination_address
      def_delegators :@frame, :udp_src_port
      def_delegators :@frame, :udp_dst_port
      def_delegators :@frame, :udp_length
      def_delegators :@frame, :udp_checksum
      def_delegators :@frame, :dhcp
      def_delegators :@frame, :optioal_tlvs
      def_delegators :@frame, :boot_message_type
      def_delegators :@frame, :message_type
      def_delegators :@frame, :hw_addr_type
      def_delegators :@frame, :hw_addr_len
      def_delegators :@frame, :hops
      def_delegators :@frame, :transaction_id
      def_delegators :@frame, :seconds
      def_delegators :@frame, :bootp_flags
      def_delegators :@frame, :client_ip_address
      def_delegators :@frame, :your_ip_address
      def_delegators :@frame, :next_server_ip_address
      def_delegators :@frame, :relay_agent_ip_address
      def_delegators :@frame, :client_mac_address
      def_delegators :@frame, :server_host_name
      def_delegators :@frame, :boot_file_name
      def_delegators :@frame, :server_identifier_tlv
      def_delegators :@frame, :renewal_time_value_tlv
      def_delegators :@frame, :rebinding_time_value_tlv
      def_delegators :@frame, :ip_address_lease_time_tlv
      def_delegators :@frame, :subnet_mask_tlv
      def_delegators :@frame, :client_identifier_tlv
      def_delegators :@frame, :requested_ip_address_tlv
      def_delegators :@frame, :parameters_list_tlv
      def_delegators :@frame, :to_binary

      private

      def self.create_from(frame)
        message = allocate
        message.instance_variable_set :@frame, frame
        message
      end

      def option_to_klass
        {
          source_mac: Mac,
          destination_mac: Mac,
          ip_source_address: IPv4Address,
          ip_destination_address: IPv4Address
        }
      end
    end
  end
end
