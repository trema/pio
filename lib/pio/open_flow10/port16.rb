require 'pio/open_flow/port'

module Pio
  module OpenFlow10
    # Port numbering (16bit).
    class Port16 < OpenFlow::Port
      port_size_in_bytes 16

      max_port_number 0xff00

      reserved_ports(in_port: 0xfff8,
                     table: 0xfff9,
                     normal: 0xfffa,
                     flood: 0xfffb,
                     all: 0xfffc,
                     controller: 0xfffd,
                     local: 0xfffe,
                     none: 0xffff)
    end
  end
end
