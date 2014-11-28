# encoding: utf-8

require 'pio/icmp/format'
require 'forwardable'

module Pio
  class Icmp
    # Base class of Request, Reply, TTL Exceeded and destination unreachable.
    class Message
      extend Forwardable

      def_delegators :@format, :destination_mac
      def_delegators :@format, :source_mac
      def_delegators :@format, :ether_type
      def_delegators :@format, :ip_version
      def_delegators :@format, :ip_header_length
      def_delegators :@format, :ip_type_of_service
      def_delegators :@format, :ip_total_length
      def_delegators :@format, :ip_identifier
      def_delegators :@format, :ip_flag
      def_delegators :@format, :ip_fragment
      def_delegators :@format, :ip_ttl
      def_delegators :@format, :ip_protocol
      def_delegators :@format, :ip_header_checksum
      def_delegators :@format, :ip_source_address
      def_delegators :@format, :ip_destination_address
      def_delegators :@format, :icmp_type
      def_delegators :@format, :icmp_code
      def_delegators :@format, :icmp_checksum
      def_delegators :@format, :icmp_identifier
      def_delegators :@format, :icmp_sequence_number
      def_delegators :@format, :echo_data
      def_delegators :@format, :to_binary

      private_class_method :new

      def initialize(user_options)
        options = self.class.const_get(:Options).new(user_options)
        @format = Icmp::Format.new(options.to_hash)
      end
    end
  end
end
