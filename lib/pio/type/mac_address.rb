require 'bindata'
require 'pio/mac'

module Pio
  module Type
    # MAC address
    class MacAddress < BinData::Primitive
      array :octets, type: :uint8, initial_length: 6

      def set(value)
        case value
        when String
          self.octets = value.split(':').map { |each| ('0x' + each).hex }
        when Integer
          self.octets = (0..5).map { |each| value >> ((5 - each) * 8) & 0xff }
        else
          self.octets = value.to_a
        end
      end

      def get
        Mac.new(octets.reduce('') do |str, each|
                  str + format('%02x', each)
                end.hex)
      end
    end
  end
end
