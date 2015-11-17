require 'pio/open_flow/action'
require 'pio/open_flow13/match'

module Pio
  module OpenFlow13
    # Set ARP sender hardware address field
    class SetArpSenderHardwareAddress < OpenFlow::Action
      action_header action_type: 25, action_length: 16

      uint16 :oxm_class, value: Match::OpenFlowBasicValue::OXM_CLASS
      bit7 :oxm_field, value: Match::ArpSenderHardwareAddress::OXM_FIELD
      bit1 :oxm_hasmask, value: 0
      uint8 :oxm_length, value: 6
      mac_address :mac_address
      string :padding, length: 2
      hide :padding

      def initialize(mac_address)
        super mac_address: mac_address
      end
    end
  end
end
