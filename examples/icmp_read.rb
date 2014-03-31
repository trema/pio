require 'pio'

icmp = Pio::Icmp.read(binary_data)
icmp.source_mac.to_s # => '00:26:82:eb:ea:d1'
