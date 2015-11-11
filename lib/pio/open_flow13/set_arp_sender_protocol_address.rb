require 'pio/open_flow/action'
require 'pio/open_flow13/match'

module Pio
  module OpenFlow13
    # Set ARP sender protocol address field
    class SetArpSenderProtocolAddress < OpenFlow::Action
      action_header action_type: 25, action_length: 16

      uint16 :oxm_class, value: Match::OpenFlowBasicValue::OXM_CLASS
      bit7 :oxm_field, value: Match::ArpSenderProtocolAddress::OXM_FIELD
      bit1 :oxm_hasmask, value: 0
      uint8 :oxm_length, value: 4
      ip_address :ip_address
      string :padding, length: 4
      hide :padding

      def initialize(ip_address)
        super ip_address: ip_address
      end
    end
  end
end
