require 'pio'

lldp = Pio::Lldp.read(binary_data)
lldp.ttl # => 120
