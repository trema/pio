require 'pio'

dhcp = Pio::Dhcp.read(binary_data)
dhcp.destination_mac.to_s  # => 'ff:ff:ff:ff:ff:ff'
