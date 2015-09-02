module Pio
  module OpenFlow10
    # Port numbering.
    class PortNumber16 < BinData::Primitive
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

      def set(value)
        if NUMBERS.key?(value)
          self.port = NUMBERS.fetch(value)
        else
          port = value.to_i
          fail ArgumentError, 'The port should be > 0' if port < 1
          fail ArgumentError, 'The port should be < 0xff00' if port >= MAX
          self.port = port
        end
      end
    end
  end
end
