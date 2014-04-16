require 'pio'

dhcp_client_mac_address = '24:db:ac:41:e5:5b'

dhcp_server_options =
  {
    source_mac: '00:26:82:eb:ea:d1',
    destination_mac: '24:db:ac:41:e5:5b',
    ip_source_address: '192.168.0.100',
    ip_destination_address: '192.168.0.1'
  }

# Client side
discover = Pio::Dhcp::Discover.new(source_mac: dhcp_client_mac_address)
discover.to_binary  # => DHCP Discover frame in binary format

# Server side
offer = Pio::Dhcp::Offer.new(dhcp_server_options
                             .merge(transaction_id: discover.transaction_id))
offer.to_binary  # => DHCP Offer frame in binary format

# Client side
request = Pio::Dhcp::Request.new(
  source_mac: dhcp_client_mac_address,
  server_identifier: dhcp_server_options[:ip_source_address],
  requested_ip_address: dhcp_server_options[:ip_destination_address],
  transaction_id: offer.transaction_id
)
request.to_binary  # => DHCP Request frame in binary format

# Server side
ack = Pio::Dhcp::Ack.new(dhcp_server_options
                         .merge(transaction_id: request.transaction_id))
ack.to_binary  # => DHCP Ack frame in binary format
