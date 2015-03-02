require 'pio/type/mac_address'

# Base module
module Pio
  # Adds ethernet_header macro.
  module EthernetHeader
    ETHER_TYPE_IP = 0x0800

    # rubocop:disable AbcSize
    def self.included(klass)
      def klass.ethernet_header(options = {})
        mac_address :destination_mac
        mac_address :source_mac
        uint16 :ether_type_internal, initial_value: options[:ether_type] || 0
        bit3 :vlan_pcp_internal, onlyif: -> { vlan? }
        bit1 :vlan_cfi, onlyif: -> { vlan? }
        bit12 :vlan_vid_internal, onlyif: -> { vlan? }
        uint16 :ether_type_vlan,
               onlyif: -> { vlan? }, initial_value: options[:ether_type] || 0
      end
    end
    # rubocop:enable AbcSize

    def ether_type
      ether_type_internal
    end

    def vlan_vid
      vlan? ? vlan_vid_internal : 0xffff
    end

    def vlan_pcp
      vlan? ? vlan_pcp_internal : 0
    end

    def vlan?
      ether_type == 0x8100
    end
  end
end
