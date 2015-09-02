require 'bindata'
require 'forwardable'
require 'pio/monkey_patch/integer'
require 'pio/open_flow10/port_number16'

module Pio
  module OpenFlow10
    # An action to output a packet to a port.
    class SendOutPort
      # OpenFlow 1.0 OFPAT_OUTPUT action format.
      class Format < BinData::Record
        endian :big

        uint16 :action_type, value: 0
        uint16 :action_length, value: 8
        port_number16 :port
        uint16 :max_length, initial_value: 2**16 - 1
      end

      def self.read(raw_data)
        send_out_port = allocate
        send_out_port.instance_variable_set :@format, Format.read(raw_data)
        send_out_port
      end

      extend Forwardable

      def_delegators :@format, :action_type
      def_delegator :@format, :action_length, :length
      def_delegators :@format, :port
      def_delegators :@format, :max_length
      def_delegator :@format, :to_binary_s, :to_binary

      # rubocop:disable MethodLength
      def initialize(user_options)
        options = if user_options.respond_to?(:to_i)
                    { port: user_options.to_i }
                  elsif PortNumber16::NUMBERS.key?(user_options)
                    { port: user_options }
                  else
                    user_options
                  end
        max_length = options[:max_length]
        if max_length && !max_length.unsigned_16bit?
          fail(ArgumentError,
               'The max_length should be an unsigned 16bit integer.')
        end
        @format = Format.new(options)
      end
      # rubocop:enable MethodLength

      def ==(other)
        return false unless other
        to_binary == other.to_binary
      end
    end
  end
end
