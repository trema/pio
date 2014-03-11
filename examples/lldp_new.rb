require 'pio'

lldp = Pio::Lldp.new(dpid: 0x123, port_number: 12)
lldp.to_binary  # => LLDP frame in binary format.
