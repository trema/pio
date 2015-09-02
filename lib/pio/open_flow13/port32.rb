require 'pio/open_flow/port'

module Pio
  module OpenFlow13
    # Port numbering (32bit).
    class Port32 < OpenFlow::Port
      port_size_in_bytes 32

      max_port_number 0xffffffff00

      reserved_ports(in_port: 0xfffffff8,
                     table: 0xfffffff9,
                     normal: 0xfffffffa,
                     flood: 0xfffffffb,
                     all: 0xfffffffc,
                     controller: 0xfffffffd,
                     local: 0xfffffffe,
                     any: 0xffffffff)
    end
  end
end
