require 'pio/ruby_dumper'
require 'pio/type/mac_address'

module Pio
  # Adds ethernet_header macro.
  module Ethernet
    # EtherType constants
    module Type
      ARP = 0x0806
      IPV4 = 0x0800
      VLAN = 0x8100
      LLDP = 0x88cc
    end

    # This method smells of :reek:TooManyStatements
    # rubocop:disable MethodLength
    def self.included(klass)
      def klass.ethernet_header(options = nil)
        mac_address :destination_mac
        mac_address :source_mac
        if options
          uint16 :ether_type, value: options.fetch(:ether_type)
        else
          uint16 :ether_type
        end
        bit3 :vlan_pcp, onlyif: :vlan?
        bit1 :vlan_cfi, onlyif: :vlan?
        bit12 :vlan_vid, onlyif: :vlan?
        uint16 :ether_type_vlan, value: :ether_type, onlyif: :vlan?
      end
    end
    # rubocop:enable MethodLength

    private

    def vlan?
      ether_type == Type::VLAN
    end
  end

  # Ethernet header generator/parser
  class EthernetHeader < BinData::Record
    include Ethernet
    include RubyDumper

    endian :big

    ethernet_header

    # rubocop:disable LineLength
    def self.inspect
      'EthernetHeader(destination_mac: mac_address, source_mac: mac_address, ether_type: uint16, vlan_pcp: bit3, vlan_cfi: bit1, vlan_vid: bit12)'
    end
    # rubocop:enable LineLength

    # rubocop:disable LineLength
    def inspect
      if vlan?
        %(#<EthernetHeader destination_mac: "#{destination_mac}", source_mac: "#{source_mac}", ether_type: #{format('0x%04x', ether_type)}, vlan_pcp: #{vlan_pcp}, vlan_cfi: #{vlan_cfi}, vlan_vid: #{vlan_vid}>)
      else
        %(#<EthernetHeader destination_mac: "#{destination_mac}", source_mac: "#{source_mac}", ether_type: #{format('0x%04x', ether_type)}>)
      end
    end
    # rubocop:enable LineLength
  end
end
