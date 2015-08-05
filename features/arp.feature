Feature: Pio::Arp
  Scenario: create an ARP request
    When I try to create a packet with:
      """
      Pio::Arp::Request.new(
        source_mac: '00:26:82:eb:ea:d1',
        sender_protocol_address: '192.168.83.3',
        target_protocol_address: '192.168.83.254'
      )
      """
    Then it should finish successfully
    And the packet has the following fields and values:
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

  Scenario: create an ARP reply
    When I try to create a packet with:
      """
      Pio::Arp::Reply.new(
        source_mac: '00:16:9d:1d:9c:c4',
        destination_mac: '00:26:82:eb:ea:d1',
        sender_protocol_address: '192.168.83.254',
        target_protocol_address: '192.168.83.3'
      )
      """
    Then it should finish successfully
    And the packet has the following fields and values:
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

  Scenario: parse arp.pcap
    When I try to parse a file named "arp.pcap" with "Pio::Arp" class
    Then it should finish successfully

  Scenario: parse arp-storm.pcap
    When I try to parse a file named "arp-storm.pcap" with "Pio::Arp" class
    Then it should finish successfully
