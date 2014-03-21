require 'pio'

discover = Pio::Dhcp::Discover.new(
  source_mac: '24:db:ac:41:e5:5b',
  transaction_id: 0xdeadbeef
)

offer = Pio::Dhcp::Offer.new(
  source_mac: '24:db:ac:41:e5:5b',
  destination_mac: '11:22:33:44:55:66',
  ip_source_address: '192.168.0.10',
  ip_destination_address: '192.168.0.1',
  transaction_id: 0xdeadbeef,
  renewal_time_value_tlv: 0xdeadbeef,
  rebinding_time_value_tlv: 0xdeadbeef,
  ip_address_lease_time_tlv: 0xdeadbeef,
  subnet_mask_tlv: '255.255.255.0'
)

request = Pio::Dhcp::Request.new(
  source_mac: '24:db:ac:41:e5:5b',
  transaction_id: 0xdeadbeef,
  server_identifier_tlv: '192.168.0.10',
  requested_ip_address_tlv: '192.168.0.1'
)

ack = Pio::Dhcp::Ack.new(
  source_mac: '24:db:ac:41:e5:5b',
  destination_mac: '11:22:33:44:55:66',
  ip_source_address: '192.168.0.10',
  ip_destination_address: '192.168.0.1',
  transaction_id: 0xdeadbeef,
  renewal_time_value_tlv: 0xdeadbeef,
  rebinding_time_value_tlv: 0xdeadbeef,
  ip_address_lease_time_tlv: 0xdeadbeef,
  subnet_mask_tlv: '255.255.255.0'
)

discover.to_binary  # => DHCP Discover frame in binary format
offer.to_binary  # => DHCP Offer frame in binary format
request.to_binary  # => DHCP Request frame in binary format
ack.to_binary  # => DHCP Ack frame in binary format
