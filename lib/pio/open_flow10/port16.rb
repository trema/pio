module Pio
  module OpenFlow10
    # Port numbering.
    class Port16 < BinData::Primitive
      NUMBERS = {
        in_port: 0xfff8,
        table: 0xfff9,
        normal: 0xfffa,
        flood: 0xfffb,
        all: 0xfffc,
        controller: 0xfffd,
        local: 0xfffe,
        none: 0xffff
      }
      MAX = 0xff00

      endian :big

      uint16 :port

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
