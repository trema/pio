require 'bindata'
require 'forwardable'

module Pio
  # An action to strip the 802.1q header.
  class StripVlanHeader
    # OpenFlow 1.0 OFPAT_STRIP_VLAN action format.
    class Format < BinData::Record
      endian :big

      uint16 :type, value: 3
      uint16 :message_length, value: 8
      bit32 :padding
      hide :padding
    end

    def self.read(raw_data)
      allocate.tap do |strip_vlan|
        strip_vlan.instance_variable_set :@format, Format.read(raw_data)
      end
    end

    extend Forwardable

    def_delegators :@format, :type
    def_delegators :@format, :message_length
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize
      @format = Format.new
    end
  end
end
