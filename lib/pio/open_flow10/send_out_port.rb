require 'pio/monkey_patch/integer'
require 'pio/open_flow/action'
require 'pio/open_flow10/port16'

module Pio
  module OpenFlow10
    # An action to output a packet to a port.
    class SendOutPort < OpenFlow::Action
      action_header action_type: 0, action_length: 8
      port16 :port
      uint16 :max_length, initial_value: 2**16 - 1

      # rubocop:disable MethodLength
      def initialize(user_options)
        options = if user_options.respond_to?(:to_i)
                    { port: user_options.to_i }
                  elsif Port16.reserved_port_name?(user_options)
                    { port: user_options }
                  else
                    user_options
                  end
        max_length = options[:max_length]
        if max_length && !max_length.unsigned_16bit?
          fail(ArgumentError,
               'The max_length should be an unsigned 16bit integer.')
        end
        super(options)
      end
      # rubocop:enable MethodLength

      def ==(other)
        return false unless other
        to_binary == other.to_binary
      end
    end
  end
end
