require 'pio/options'

module Pio
  class Lldp
    # User options for creating an LLDP frame.
    class Options < Pio::Options
      mandatory_option :dpid
      mandatory_option :port_number
      option :destination_mac
      option :source_mac

      DEFAULT_DESTINATION_MAC = '01:80:c2:00:00:0e'.freeze
      DEFAULT_SOURCE_MAC = '01:02:03:04:05:06'.freeze

      def initialize(options)
        validate options
        @dpid = options[:dpid].freeze
        @port_id = options[:port_number].freeze
        @destination_mac =
          Mac.new(options[:destination_mac] || DEFAULT_DESTINATION_MAC).freeze
        @source_mac =
          Mac.new(options[:source_mac] || DEFAULT_SOURCE_MAC).freeze
      end

      def to_hash
        {
          chassis_id: @dpid,
          port_id: @port_id,
          destination_mac: @destination_mac,
          source_mac: @source_mac
        }.freeze
      end
    end
  end
end
