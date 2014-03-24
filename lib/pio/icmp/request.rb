# -*- coding: utf-8 -*-
require 'pio/icmp/message'
require 'pio/icmp/options'
require 'pio/mac'

module Pio
  class Icmp
    # ICMP Request packet generator
    class Request < Message
      TYPE = 8
      public_class_method :new

      # User options for creating an ICMP Request.
      class Options < Pio::Icmp::Options
        DEFAULT_IDENTIFIER = 0x0100
        DEFAULT_SEQUENCE_NUMBER = 0

        mandatory_option :source_mac
        mandatory_option :destination_mac
        mandatory_option :ip_source_address
        mandatory_option :ip_destination_address
        option :identifier
        option :sequence_number
        option :echo_data

        # rubocop:disable MethodLength

        def initialize(options)
          validate_options(options)
          @type = TYPE
          @source_mac = Mac.new(options[:source_mac]).freeze
          @destination_mac = Mac.new(options[:destination_mac]).freeze
          @ip_source_address =
            IPv4Address.new(options[:ip_source_address]).freeze
          @ip_destination_address =
            IPv4Address.new(options[:ip_destination_address]).freeze
          @identifier =
            options[:icmp_identifier] ||
            options[:identifier] ||
            DEFAULT_IDENTIFIER
          @sequence_number =
            options[:icmp_sequence_number] ||
            options[:sequence_number] ||
            DEFAULT_SEQUENCE_NUMBER
          @echo_data = options[:echo_data] || DEFAULT_ECHO_DATA
        end

        # rubocop:enable MethodLength
      end
    end
  end
end
