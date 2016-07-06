Feature: Arp Reply
  Scenario: create an ARP reply
    When I create a packet with:
      """
      Pio::Arp::Reply.new(
        destination_mac: '00:26:82:eb:ea:d1',
        source_mac: '00:16:9d:1d:9c:c4',
        sender_protocol_address: '192.168.83.254',
        target_protocol_address: '192.168.83.3'
      )
      """
    Then the packet has the following fields and values:
      | field                   |             value |
      | class                   |   Pio::Arp::Reply |
      | destination_mac         | 00:26:82:eb:ea:d1 |
      | source_mac              | 00:16:9d:1d:9c:c4 |
      | ether_type              |              2054 |
      | hardware_type           |                 1 |
      | protocol_type           |              2048 |
      | hardware_length         |                 6 |
      | protocol_length         |                 4 |
      | operation               |                 2 |
      | sender_hardware_address | 00:16:9d:1d:9c:c4 |
      | sender_protocol_address |    192.168.83.254 |
      | target_hardware_address | 00:26:82:eb:ea:d1 |
      | target_protocol_address |      192.168.83.3 |

  Scenario: convert to Ruby code
    When I eval the following Ruby code:
      """ruby
      Pio::Arp::Reply.new(
        destination_mac: '00:26:82:eb:ea:d1',
        source_mac: '00:16:9d:1d:9c:c4',
        sender_protocol_address: '192.168.83.254',
        target_protocol_address: '192.168.83.3'
      ).to_ruby
      """
    Then the result of eval should be:
      """ruby
      [
        0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # destination_mac
        0x00, 0x16, 0x9d, 0x1d, 0x9c, 0xc4, # source_mac
        0x08, 0x06, # ether_type
        0x00, 0x01, # hardware_type
        0x08, 0x00, # protocol_type
        0x06, # hardware_length
        0x04, # protocol_length
        0x00, 0x02, # operation
        0x00, 0x16, 0x9d, 0x1d, 0x9c, 0xc4, # sender_hardware_address
        0xc0, 0xa8, 0x53, 0xfe, # sender_protocol_address
        0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # target_hardware_address
        0xc0, 0xa8, 0x53, 0x03, # target_protocol_address
      ].pack('C*')
      """

  Scenario: parse arp.pcap
    Then I parse a file named "arp.pcap" with "Pio::Arp" class

  Scenario: parse arp-storm.pcap
    Then I parse a file named "arp-storm.pcap" with "Pio::Arp" class
