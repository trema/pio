# encoding: utf-8

require 'bindata'
require 'pio/mac'

module Pio
  module Type
    # MAC address
    class MacAddress < BinData::Primitive
      array :octets, type: :uint8, initial_length: 6

      def set(value)
        self.octets = value.to_a
      end

      def get
        Mac.new(octets.reduce('') do |str, each|
                  str + sprintf('%02x', each)
                end.hex)
      end
    end
  end
end
