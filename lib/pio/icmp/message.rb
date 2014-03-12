# -*- coding: utf-8 -*-
require 'pio/icmp/frame'
require 'forwardable'

module Pio
  class Icmp
    # Base class of Request, Reply, TTL Exceeded and destination unreachable.
    class Message
      extend Forwardable

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

      def self.create_from(frame)
        message = allocate
        message.instance_variable_set :@frame, frame
        message
      end

      private_class_method :new

      def initialize(user_options)
        options = self.class.const_get(:Options).new(user_options)
        @frame = Icmp::Frame.new(options.to_hash)
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
