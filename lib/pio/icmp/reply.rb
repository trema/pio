require 'pio/icmp/message'
require 'pio/icmp/options'
require 'pio/mac'

module Pio
  class Icmp
    # ICMP Reply packet generator
    class Reply < Message
      TYPE = 0
      public_class_method :new

      # User options for creating an ICMP Reply.
      class Options < Pio::Icmp::Options
        mandatory_option :source_mac
        mandatory_option :destination_mac
        mandatory_option :source_ip_address
        mandatory_option :destination_ip_address
        mandatory_option :identifier
        mandatory_option :sequence_number
        option :echo_data

        # rubocop:disable MethodLength
        # rubocop:disable AbcSize
        def initialize(options)
          validate options
          @type = TYPE

          @source_mac = Mac.new(options[:source_mac]).freeze
          @destination_mac = Mac.new(options[:destination_mac]).freeze
          @source_ip_address =
            IPv4Address.new(options[:source_ip_address]).freeze
          @destination_ip_address =
            IPv4Address.new(options[:destination_ip_address]).freeze
          @identifier = options[:identifier]
          @sequence_number = options[:sequence_number]
          @echo_data = options[:echo_data] || ''
        end
        # rubocop:enable AbcSize
        # rubocop:enable MethodLength
      end
    end
  end
end
