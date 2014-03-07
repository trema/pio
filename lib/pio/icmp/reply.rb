# -*- coding: utf-8 -*-
require 'pio/icmp/message'
require 'pio/mac'
require 'pio/options'

module Pio
  class Icmp
    # ICMP Reply packet generator
    class Reply < Message
      TYPE = 0
      public_class_method :new

      # User options for creating an ICMP Reply.
      class Options < Pio::Options
        mandatory_option :source_mac
        mandatory_option :destination_mac
        mandatory_option :ip_source_address
        mandatory_option :ip_destination_address
        option :icmp_identifier
        option :icmp_sequence_number
        option :echo_data

        def initialize(options)
          validate_options(options)
          @source_mac = Mac.new(options[:source_mac])
          @destination_mac = Mac.new(options[:destination_mac])
          @ip_source_address =
            IPv4Address.new(options[:ip_source_address])
          @ip_destination_address =
            IPv4Address.new(options[:ip_destination_address])
          @icmp_identifier = options[:icmp_identifier]
          @icmp_sequence_number = options[:icmp_sequence_number]
          @echo_data = options[:echo_data] || ''
        end

        def to_hash
          {
            icmp_type: TYPE,
            source_mac: @source_mac,
            destination_mac: @destination_mac,
            ip_source_address: @ip_source_address,
            ip_destination_address: @ip_destination_address,
            icmp_identifier: @icmp_identifier,
            icmp_sequence_number: @icmp_sequence_number,
            echo_data: @echo_data
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
