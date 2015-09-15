require 'bindata'
require 'forwardable'

module Pio
  # Vendor defined action
  class VendorAction
    # OpenFlow 1.0 OFPAT_VENDOR action format.
    class Format < BinData::Record
      endian :big

      uint16 :action_type, value: 0xffff
      uint16 :action_length, value: 8
      uint32 :vendor
    end

    def self.read(raw_data)
      allocate.tap do |strip_vlan|
        strip_vlan.instance_variable_set :@format, Format.read(raw_data)
      end
    end

    extend Forwardable

    def_delegators :@format, :action_type
    def_delegator :@format, :action_length, :length
    def_delegators :@format, :vendor
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(vendor)
      @format = Format.new(vendor: vendor)
    end
  end
end
