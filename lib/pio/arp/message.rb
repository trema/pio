require 'forwardable'
require 'pio/arp/format'

module Pio
  class Arp
    # Base class of ARP Request and Reply
    class Message
      extend Forwardable

      def_delegators :@format, :destination_mac
      def_delegators :@format, :source_mac
      def_delegators :@format, :ether_type
      def_delegators :@format, :hardware_type
      def_delegators :@format, :protocol_type
      def_delegators :@format, :hardware_length
      def_delegators :@format, :protocol_length
      def_delegators :@format, :operation
      def_delegators :@format, :sender_hardware_address
      def_delegators :@format, :sender_protocol_address
      def_delegators :@format, :target_hardware_address
      def_delegators :@format, :target_protocol_address
      def_delegators :@format, :to_binary

      private_class_method :new

      def initialize(user_options)
        options = self.class.const_get(:Options).new(user_options.dup.freeze)
        @format = Arp::Format.new(options.to_hash)
      end
    end
  end
end
