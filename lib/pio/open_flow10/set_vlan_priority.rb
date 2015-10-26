require 'pio/open_flow/action'

module Pio
  module OpenFlow10
    # An action to modify the VLAN priority of a packet.
    class SetVlanPriority < OpenFlow::Action
      action_header action_type: 2, action_length: 8
      uint16 :vlan_priority
      string :padding, length: 2
      hide :padding

      def initialize(number)
        priority = number.to_i
        if priority < 0 || priority > 7
          fail ArgumentError, 'VLAN priority must be between 0 and 7 inclusive'
        end
        super(vlan_priority: priority)
      rescue NoMethodError
        raise TypeError, 'VLAN priority must be an Integer.'
      end
    end
  end
end
