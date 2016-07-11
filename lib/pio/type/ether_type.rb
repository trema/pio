require 'bindata'

module Pio
  module Type
    # Ether type
    class EtherType < BinData::Primitive
      endian :big

      uint16 :ether_type

      def set(value)
        self.ether_type = value
      end

      def get
        ether_type
      end

      def to_bytes
        byte1 = format('%02x', (self & 0xff00) >> 8)
        byte2 = format('%02x', self & 0xff)
        "0x#{byte1}, 0x#{byte2}"
      end

      def inspect
        Kernel.format '0x%04x', self
      end
    end
  end
end
