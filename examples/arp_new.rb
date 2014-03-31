require 'pio'

request = Pio::Arp::Request.new(
  source_mac: '00:26:82:eb:ea:d1',
  sender_protocol_address: '192.168.83.3',
  target_protocol_address: '192.168.83.254'
)
request.to_binary  # => Arp Request frame in binary format.

reply = Pio::Arp::Reply.new(
  source_mac: '00:16:9d:1d:9c:c4',
  destination_mac: '00:26:82:eb:ea:d1',
  sender_protocol_address: '192.168.83.254',
  target_protocol_address: '192.168.83.3'
)
reply.to_binary  # => Arp Reply frame in binary format.
