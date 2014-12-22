require 'pio'

packet_in = Pio::PacketIn.read(binary_data)
packet_in.in_port # => 1
packet_in.buffer_id # => 4294967040
