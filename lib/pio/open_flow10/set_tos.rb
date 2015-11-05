require 'pio/monkey_patch/integer'
require 'pio/open_flow/action'

module Pio
  module OpenFlow10
    # An action to modify the IP ToS/DSCP field of a packet.
    class SetTos < OpenFlow::Action
      action_header action_type: 8, action_length: 8
      uint8 :type_of_service
      string :padding, length: 3
      hide :padding

      def initialize(type_of_service)
        # tos (IP ToS) value consists of 8 bits, of which only the
        # 6 high-order bits belong to DSCP, the 2 low-order bits must
        # be zero.
        unless type_of_service.unsigned_8bit? && type_of_service % 4 == 0
          fail ArgumentError, 'Invalid type_of_service (ToS) value.'
        end
        super(type_of_service: type_of_service)
      end
    end
  end
end
