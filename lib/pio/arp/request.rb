# -*- coding: utf-8 -*-
require 'pio/arp/message'
require 'pio/mac'
require 'pio/options'

module Pio
  class Arp
    # ARP Request packet generator
    class Request < Message
      OPERATION = 1
      public_class_method :new

      # User options for creating an Arp Request.
      class Options < Pio::Options
        mandatory_option :source_mac
        mandatory_option :sender_protocol_address
        mandatory_option :target_protocol_address

        BROADCAST_MAC = Mac.new(0xffffffffffff)
        ALL_ZERO_MAC = Mac.new(0)

        def initialize(options)
          validate_options(options)
          @source_mac = Mac.new(options[:source_mac])
          @sender_protocol_address =
            IPv4Address.new(options[:sender_protocol_address])
          @target_protocol_address =
            IPv4Address.new(options[:target_protocol_address])
        end

        def to_hash
          {
            operation: OPERATION,
            source_mac: @source_mac,
            destination_mac: BROADCAST_MAC,
            sender_hardware_address: @source_mac,
            target_hardware_address: ALL_ZERO_MAC,
            sender_protocol_address: @sender_protocol_address,
            target_protocol_address: @target_protocol_address
          }
        end
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
