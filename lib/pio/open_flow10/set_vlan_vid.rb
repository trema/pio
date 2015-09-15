require 'pio/open_flow10/set_vlan'

module Pio
  # An action to modify the VLAN ID of a packet.
  class SetVlanVid < SetVlan
    def_format :vlan_id, 1

    def initialize(number)
      vlan_id = number.to_i
      unless vlan_id >= 1 && vlan_id <= 4095
        fail ArgumentError, 'VLAN ID must be between 1 and 4095 inclusive'
      end
      @format = Format.new(vlan_id: vlan_id)
    rescue NoMethodError
      raise TypeError, 'VLAN ID must be an Integer.'
    end
  end
end
