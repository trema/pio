require 'pio'

arp = Pio::Arp.read(binary_data)
arp.source_mac.to_s # => '00:26:82:eb:ea:d1'
