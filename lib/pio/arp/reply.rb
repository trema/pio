require 'pio/arp/message'
require 'pio/mac'
require 'pio/options'

module Pio
  class Arp
    # ARP Reply packet generator
    class Reply < Message
      OPERATION = 2
      public_class_method :new

      # rubocop:disable LineLength
      def inspect
        %(#<Arp::Reply destination_mac: "#{destination_mac}", source_mac: "#{source_mac}", ether_type: #{format '0x%04x', ether_type}, hardware_type: #{hardware_type}, protocol_length: #{protocol_length}, operation: #{operation}, sender_hardware_address: "#{sender_hardware_address}", sender_protocol_address: "#{sender_protocol_address}", target_hardware_address: "#{target_hardware_address}", target_protocol_address: "#{target_protocol_address}">)
      end
      # rubocop:enable LineLength

      # User options for creating an Arp Reply.
      class Options < Pio::Options
        mandatory_option :source_mac
        mandatory_option :destination_mac
        mandatory_option :sender_protocol_address
        mandatory_option :target_protocol_address

        def initialize(options)
          validate options
          @source_mac = Mac.new(options[:source_mac]).freeze
          @destination_mac = Mac.new(options[:destination_mac]).freeze
          @sender_protocol_address =
            IPv4Address.new(options[:sender_protocol_address]).freeze
          @target_protocol_address =
            IPv4Address.new(options[:target_protocol_address]).freeze
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
          }.freeze
        end
      end
    end
  end
end
