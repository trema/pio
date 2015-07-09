require 'forwardable'

# Base module.
module Pio
  module OpenFlow13
    # Output to switch port.
    class SendOutPort
      # OpenFlow 1.3.4 OFPAT_OUTPUT action format.
      class Format < BinData::Record
        NO_BUFFER = 0xffff

        endian :big

        uint16 :action_type, value: 0
        uint16 :action_length, value: 16
        uint32 :port
        uint16 :max_length, initial_value: NO_BUFFER
        uint48 :padding
      end

      def self.read(raw_data)
        allocate.tap do |send_out_port|
          send_out_port.instance_variable_set :@format, Format.read(raw_data)
        end
      end

      extend Forwardable

      def_delegators :@format, :action_type
      def_delegators :@format, :action_length
      def_delegators :@format, :port
      def_delegator :@format, :to_binary_s, :to_binary

      def initialize(port)
        @format = Format.new(port: port)
      end

      def max_length
        case @format.max_length
        when Format::NO_BUFFER
          :no_buffer
        else
          @format.max_length
        end
      end
    end
  end
end
