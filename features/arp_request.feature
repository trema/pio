Feature: Arp Request
  Scenario: create an ARP request
    When I create a packet with:
      """
      Pio::Arp::Request.new(
        source_mac: '00:26:82:eb:ea:d1',
        sender_protocol_address: '192.168.83.3',
        target_protocol_address: '192.168.83.254'
      )
      """
    Then the packet has the following fields and values:
      | field                   |             value |
      | class                   | Pio::Arp::Request |
      | destination_mac         | ff:ff:ff:ff:ff:ff |
      | source_mac              | 00:26:82:eb:ea:d1 |
      | ether_type              |              2054 |
      | hardware_type           |                 1 |
      | protocol_type           |              2048 |
      | hardware_length         |                 6 |
      | protocol_length         |                 4 |
      | operation               |                 1 |
      | sender_hardware_address | 00:26:82:eb:ea:d1 |
      | sender_protocol_address |      192.168.83.3 |
      | target_hardware_address | 00:00:00:00:00:00 |
      | target_protocol_address |    192.168.83.254 |

  Scenario: convert to Ruby code
    When I eval the following Ruby code:
      """ruby
      Pio::Arp::Request.new(
        source_mac: '00:26:82:eb:ea:d1',
        sender_protocol_address: '192.168.83.3',
        target_protocol_address: '192.168.83.254'
      ).to_ruby
      """
    Then the result of eval should be:
      """ruby
      [
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, # destination_mac
        0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # source_mac
        0x08, 0x06, # ether_type
        0x00, 0x01, # hardware_type
        0x08, 0x00, # protocol_type
        0x06, # hardware_length
        0x04, # protocol_length
        0x00, 0x01, # operation
        0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # sender_hardware_address
        0xc0, 0xa8, 0x53, 0x03, # sender_protocol_address
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, # target_hardware_address
        0xc0, 0xa8, 0x53, 0xfe, # target_protocol_address
      ].pack('C*')
      """
