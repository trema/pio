require 'pio'

discover = Pio::Dhcp::Discover.new(source_mac: '24:db:ac:41:e5:5b')
discover.to_binary  # => DHCP Discover frame in binary format

offer = Pio::Dhcp::Offer.new(
  source_mac: '00:26:82:eb:ea:d1',
  destination_mac: '24:db:ac:41:e5:5b',
  ip_source_address: '192.168.0.100',
  ip_destination_address: '192.168.0.1',
  transaction_id: discover.transaction_id
)
offer.to_binary  # => DHCP Offer frame in binary format

request = Pio::Dhcp::Request.new(
  source_mac: '24:db:ac:41:e5:5b',
  server_identifier: '192.168.0.100',
  requested_ip_address: '192.168.0.1',
  transaction_id: offer.transaction_id
)
request.to_binary  # => DHCP Request frame in binary format

ack = Pio::Dhcp::Ack.new(
  source_mac: '00:26:82:eb:ea:d1',
  destination_mac: '24:db:ac:41:e5:5b',
  ip_source_address: '192.168.0.100',
  ip_destination_address: '192.168.0.1',
  transaction_id: request.transaction_id
)
ack.to_binary  # => DHCP Ack frame in binary format
