# -*- coding: utf-8 -*-

module Pio
  class Arp
    class Request < Message
      # User options for creating an Arp Request.
      class Options
        OPERATION = 1
        BROADCAST_MAC = Mac.new(0xffffffffffff)
        ALL_ZERO_MAC = Mac.new(0)

        def initialize(options)
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
