require 'pio'

packet_in = Pio::PacketIn.read(binary_data)
packet_in.xid # => 123
