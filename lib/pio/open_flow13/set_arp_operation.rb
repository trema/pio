require 'pio/open_flow/action'
require 'pio/open_flow13/match'

module Pio
  module OpenFlow13
    # Set ARP operation field
    class SetArpOperation < OpenFlow::Action
      action_header action_type: 25, action_length: 16

      uint16 :oxm_class, value: Match::OpenFlowBasicValue::OXM_CLASS
      bit7 :oxm_field, value: Match::ArpOperation::OXM_FIELD
      bit1 :oxm_hasmask, value: 0
      uint8 :oxm_length, value: 2
      uint16 :operation
      string :padding, length: 6
      hide :padding

      def initialize(operation)
        super operation: operation
      end
    end
  end
end
