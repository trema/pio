# -*- coding: utf-8 -*-
module Pio
  class Lldp
    # User options for creating an LLDP frame.
    class Options
      DEFAULT_DESTINATION_MAC = '01:80:c2:00:00:0e'
      DEFAULT_SOURCE_MAC = '01:02:03:04:05:06'

      def initialize(options)
        @dpid = mandatory_option(options, :dpid)
        @port_id = mandatory_option(options, :port_number)
        @destination_mac =
          Mac.new(options[:destination_mac] || DEFAULT_DESTINATION_MAC)
        @source_mac = Mac.new(options[:source_mac] || DEFAULT_SOURCE_MAC)
      end

      def to_hash
        {
         chassis_id: @dpid,
         port_id: @port_id,
         destination_mac: @destination_mac,
         source_mac: @source_mac
        }
      end

      private

      def mandatory_option(options, key)
        value = options.fetch(key) do |missing_key|
          fail ArgumentError, "The #{missing_key} option should be passed."
        end
        fail(ArgumentError,
             "The #{key} option shouldn't be #{value.inspect}.") unless value
        value
      end
    end
  end
end
