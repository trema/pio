require 'pio/open_flow/action'
require 'pio/open_flow13/port32'

# Base module.
module Pio
  module OpenFlow13
    # Output to switch port.
    class SendOutPort < OpenFlow::Action
      NO_BUFFER = 0xffff

      action_header action_type: 0, action_length: 16
      port32 :port
      uint16 :max_length, initial_value: NO_BUFFER
      uint48 :padding

      def initialize(port)
        super(port: port)
      end

      def max_length
        case @format.max_length
        when NO_BUFFER
          :no_buffer
        else
          @format.max_length
        end
      end
    end
  end
end
