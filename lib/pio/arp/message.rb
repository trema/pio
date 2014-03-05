# -*- coding: utf-8 -*-
require 'forwardable'
require 'pio/arp/frame'

module Pio
  class Arp
    # Base class of ARP Request and Reply
    class Message
      extend Forwardable

      def self.create_from(frame)
        message = allocate
        message.instance_variable_set :@frame, frame
        message
      end

      def initialize(user_options)
        options = self.class.const_get(:Options).new(user_options)
        @frame = Arp::Frame.new(options.to_hash)
      end

      def_delegators :@frame, :destination_mac
      def_delegators :@frame, :source_mac
      def_delegators :@frame, :ether_type
      def_delegators :@frame, :hardware_type
      def_delegators :@frame, :protocol_type
      def_delegators :@frame, :hardware_length
      def_delegators :@frame, :protocol_length
      def_delegators :@frame, :operation
      def_delegators :@frame, :sender_hardware_address
      def_delegators :@frame, :sender_protocol_address
      def_delegators :@frame, :target_hardware_address
      def_delegators :@frame, :target_protocol_address
      def_delegators :@frame, :to_binary
    end
  end
end
