module Pio
  module OpenFlow13
    # Port numbering.
    class Port32 < BinData::Primitive
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

      uint32 :port

      def get
        NUMBERS.invert.fetch(port)
      rescue KeyError
        port
      end

      def set(port)
        if NUMBERS.key?(port)
          self.port = NUMBERS.fetch(port)
        else
          port_number = port.to_i
          fail ArgumentError, 'The port should be > 0' if port_number < 1
          if port_number >= MAX
            fail ArgumentError, "The port should be < #{MAX.to_hex}"
          end
          self.port = port_number
        end
      end
    end
  end
end
