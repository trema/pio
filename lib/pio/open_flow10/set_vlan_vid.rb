require 'pio/open_flow10/set_vlan'

module Pio
  # An action to modify the VLAN ID of a packet.
  class SetVlanVid < SetVlan
    def_format :vlan_id, 1

    # Creates an action to modify the VLAN ID of a packet. The VLAN ID
    # is 16-bits long but the actual VID (VLAN Identifier) of the IEEE
    # 802.1Q frame is 12-bits.
    #
    # @example
    #   ActionSetVlanVid.new(number)
    #
    # @param [Integer] number
    #   the VLAN ID to set to. Only the lower 12-bits are used.
    #
    # @raise [ArgumentError] if vlan_id not within 1 and 4095 inclusive.
    # @raise [TypeError] if vlan_id is not an Integer.
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
