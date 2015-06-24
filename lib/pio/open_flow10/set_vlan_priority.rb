require 'pio/open_flow10/set_vlan'

module Pio
  # An action to modify the VLAN priority of a packet.
  class SetVlanPriority < SetVlan
    def_format :vlan_priority, 2

    def initialize(number)
      priority = number.to_i
      if priority < 0 || priority > 7
        fail ArgumentError, 'VLAN priority must be between 0 and 7 inclusive'
      end
      @format = Format.new(vlan_priority: priority)
    rescue NoMethodError
      raise TypeError, 'VLAN priority must be an Integer.'
    end
  end
end
