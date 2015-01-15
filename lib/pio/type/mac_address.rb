require 'bindata'
require 'pio/mac'

module Pio
  module Type
    # MAC address
    class MacAddress < BinData::Primitive
      array :octets, type: :uint8, initial_length: 6

      def set(value)
        self.octets = Mac.new(value).to_a
      end

      def get
        Mac.new(octets.reduce('') do |str, each|
                  str + format('%02x', each)
                end.hex)
      end
    end
  end
end
