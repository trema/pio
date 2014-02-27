# -*- coding: utf-8 -*-
require 'pio/icmp/frame'
require 'pio/message_util'
require 'forwardable'

module Pio
  class Icmp
    # Base class of Request, Reply, TTL Exceeded and destination unreachable.
    class Message
      extend Forwardable
      include MessageUtil

      def initialize(options)
        @options = options
        @frame = Icmp::Frame.new(option_hash)
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
      def_delegators :@frame, :icmp_type
      def_delegators :@frame, :icmp_code
      def_delegators :@frame, :icmp_checksum
      def_delegators :@frame, :icmp_identifier
      def_delegators :@frame, :icmp_sequence_number
      def_delegators :@frame, :echo_data
      def_delegators :@frame, :to_binary

      private

      def self.create_from(frame)
        message = allocate
        message.instance_variable_set :@frame, frame
        message
      end

      # rubocop:disable MethodLength
      def default_options
        {
          ip_type_of_service: @options[:ip_type_of_service],
          ip_identifier: @options[:ip_identifier],
          ip_flag: @options[:ip_flag],
          ip_fragment: @options[:ip_fragment],
          ip_ttl: @options[:ip_ttl],
          icmp_type: self.class::TYPE,
          icmp_code: @options[:icmp_code],
          icmp_identifier: @options[:icmp_identifier],
          icmp_sequence_number: @options[:icmp_sequence_number],
          echo_data: @options[:echo_data]
        }
      end
      # rubocop:enable MethodLength

      def user_options
        @options.merge(
          source_mac: @options[:source_mac],
          destination_mac: @options[:destination_mac],
          ip_source_address: @options[:ip_source_address],
          ip_destination_address: @options[:ip_destination_address]
        )
      end

      def mandatory_options
        [
         :source_mac,
         :destination_mac,
         :ip_source_address,
         :ip_destination_address
        ]
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

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
