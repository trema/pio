require 'pio/open_flow/action'

module Pio
  module OpenFlow10
    # An action to modify the VLAN ID of a packet.
    class SetVlanVid < OpenFlow::Action
      action_header action_type: 1, action_length: 8
      uint16 :vlan_id
      string :padding, length: 2
      hide :padding

      def initialize(number)
        vlan_id = number.to_i
        unless vlan_id >= 1 && vlan_id <= 4095
          fail ArgumentError, 'VLAN ID must be between 1 and 4095 inclusive'
        end
        super(vlan_id: vlan_id)
      rescue NoMethodError
        raise TypeError, 'VLAN ID must be an Integer.'
      end
    end
  end
end
