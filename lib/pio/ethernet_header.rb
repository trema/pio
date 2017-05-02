# frozen_string_literal: true

require 'pio/class_inspector'
require 'pio/instance_inspector'
require 'pio/ruby_dumper'
require 'pio/type/ether_type'
require 'pio/type/mac_address'

module Pio
  # Adds ethernet_header macro.
  module Ethernet
    MINIMUM_FRAME_SIZE = 64

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
          ether_type :ether_type, value: options.fetch(:ether_type)
        else
          ether_type :ether_type
        end
        bit3 :vlan_pcp, onlyif: :vlan?
        bit1 :vlan_cfi, onlyif: :vlan?
        bit12 :vlan_vid, onlyif: :vlan?
        uint16 :ether_type_vlan, value: :ether_type, onlyif: :vlan?
      end
    end
    # rubocop:enable MethodLength

    def ethernet_header_length
      vlan? ? 18 : 14
    end

    private

    def vlan?
      ether_type == Type::VLAN
    end
  end

  # Ethernet header generator/parser
  class EthernetHeader < BinData::Record
    extend ClassInspector
    include Ethernet
    include InstanceInspector
    include RubyDumper

    endian :big

    ethernet_header
  end
end
