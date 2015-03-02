require 'pio/type/mac_address'

module Pio
  # Adds ethernet_header macro.
  module EthernetHeader
    # EtherType constants for ethernet_header.ether_type.
    module EtherType
      ARP = 0x0806
      IPV4 = 0x0800
      VLAN = 0x8100
      LLDP = 0x88cc
    end

    # This method smells of :reek:TooManyStatements
    def self.included(klass)
      def klass.ethernet_header(options)
        mac_address :destination_mac
        mac_address :source_mac
        uint16 :ether_type, value: options.fetch(:ether_type)
        bit3 :vlan_pcp_internal, onlyif: :vlan?
        bit1 :vlan_cfi, onlyif: :vlan?
        bit12 :vlan_vid_internal, onlyif: :vlan?
        uint16 :ether_type_vlan, value: :ether_type, onlyif: :vlan?
      end
    end

    def vlan_vid
      vlan? ? vlan_vid_internal : 0xffff
    end

    def vlan_pcp
      vlan? ? vlan_pcp_internal : 0
    end

    def vlan?
      ether_type == EtherType::VLAN
    end
  end
end
