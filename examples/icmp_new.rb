require 'pio'

request = Pio::Icmp::Request.new(
  source_mac: '00:26:82:eb:ea:d1',
  destination_mac: '00:26:82:eb:ea:d1',
  ip_source_address: '192.168.83.3',
  ip_destination_address: '192.168.83.254'
)
request.to_binary  # => ICMP Request frame in binary format.

reply = Pio::Icmp::Reply.new(
  destination_mac: '00:26:82:eb:ea:d1',
  source_mac: '00:00:00:00:00:01',
  ip_source_address: '192.168.0.1',
  ip_destination_address: '192.168.0.2',
  # The ICMP Identifier and the ICMP Sequence number
  # should be same as those of the request.
  icmp_identifier: request.icmp_identifier,
  icmp_sequence_number: request.icmp_sequence_number,
  echo_data: request.echo_data
)
reply.to_binary  # => ICMP Reply frame in binary format.
