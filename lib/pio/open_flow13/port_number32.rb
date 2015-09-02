module Pio
  module OpenFlow13
    # Port numbering.
    class PortNumber32 < BinData::Primitive
      NUMBERS = {
        in_port: 0xfffffff8,
        table: 0xfffffff9,
        normal: 0xfffffffa,
        flood: 0xfffffffb,
        all: 0xfffffffc,
        controller: 0xfffffffd,
        local: 0xfffffffe,
        any: 0xffffffff
      }
      MAX = 0xffffff00

      endian :big

      uint32 :port_number

      def get
        NUMBERS.invert.fetch(port_number)
      rescue KeyError
        port_number
      end

      def set(value)
        if NUMBERS.key?(value)
          self.port_number = NUMBERS.fetch(value)
        else
          port_number = value.to_i
          fail ArgumentError, 'The port_number should be > 0' if port_number < 1
          if port_number >= MAX
            fail ArgumentError, "The port_number should be < #{MAX.to_hex}"
          end
          self.port_number = port_number
        end
      end
    end
  end
end
