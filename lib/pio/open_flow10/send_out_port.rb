require 'bindata'
require 'pio/monkey_patch/integer'
require 'pio/open_flow/port_number'

module Pio
  module OpenFlow10
    # An action to output a packet to a port.
    class SendOutPort
      # OpenFlow 1.0 OFPAT_OUTPUT action format.
      class Format < BinData::Record
        endian :big

        uint16 :action_type, value: 0
        uint16 :message_length, value: 8
        port_number :port_number
        uint16 :max_length, initial_value: 2**16 - 1
      end

      def self.read(raw_data)
        send_out_port = allocate
        send_out_port.instance_variable_set :@format, Format.read(raw_data)
        send_out_port
      end

      # rubocop:disable MethodLength
      def initialize(user_options)
        options = if user_options.respond_to?(:to_i)
                    { port_number: user_options.to_i }
                  elsif PortNumber::NUMBERS.key?(user_options)
                    { port_number: user_options }
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
        to_binary_s == other.to_binary_s
      end

      def to_binary
        @format.to_binary_s
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end
  end
end
