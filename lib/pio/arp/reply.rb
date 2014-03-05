# -*- coding: utf-8 -*-
require 'forwardable'
require 'pio/arp/message'
require 'pio/mac'

module Pio
  class Arp
    # ARP Reply packet generator
    class Reply < Message
      # User options for creating an Arp Reply.
      class Options
        OPERATION = 2

        def initialize(options)
          @source_mac = Mac.new(options[:source_mac])
          @destination_mac = Mac.new(options[:destination_mac])
          @sender_protocol_address =
            IPv4Address.new(options[:sender_protocol_address])
          @target_protocol_address =
            IPv4Address.new(options[:target_protocol_address])
        end

        def to_hash
          {
            operation: OPERATION,
            source_mac: @source_mac,
            destination_mac: @destination_mac,
            sender_hardware_address: @source_mac,
            target_hardware_address: @destination_mac,
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
