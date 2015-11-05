require 'pio/monkey_patch/integer'
require 'pio/open_flow/action'

module Pio
  module OpenFlow10
    # An action to modify the source TCP/UDP port of a packet.
    class SetTransportSourcePort < OpenFlow::Action
      action_header action_type: 9, action_length: 8
      uint16 :port
      string :padding, length: 2
      hide :padding

      def initialize(number)
        port = number.to_i
        unless port.unsigned_16bit?
          fail ArgumentError, 'TCP/UDP port must be an unsigned 16-bit integer.'
        end
        super(port: port)
      rescue NoMethodError
        raise TypeError, 'TCP/UDP port must be an unsigned 16-bit integer.'
      end
    end

    # An action to modify the source TCP/UDP port of a packet.
    class SetTransportDestinationPort < OpenFlow::Action
      action_header action_type: 10, action_length: 8
      uint16 :port
      string :padding, length: 2
      hide :padding

      def initialize(number)
        port = number.to_i
        unless port.unsigned_16bit?
          fail ArgumentError, 'TCP/UDP port must be an unsigned 16-bit integer.'
        end
        super(port: port)
      rescue NoMethodError
        raise TypeError, 'TCP/UDP port must be an unsigned 16-bit integer.'
      end
    end
  end
end
