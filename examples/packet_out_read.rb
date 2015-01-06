require 'pio'

packet_out = Pio::PacketOut.read(binary_data)
packet_out.actions.length # => 1
packet_out.actions[0] # => Pio::SendOutPort
packet_out.actions[0].port_number # => 2
