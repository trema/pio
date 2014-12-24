module Pio
  # Port numbering.
  class PortNumber < BinData::Primitive
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

    uint16 :port_number

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
          fail ArgumentError, 'The port_number should be < 0xff00'
        end
        self.port_number = port_number
      end
    end
  end
end
