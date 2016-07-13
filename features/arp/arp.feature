Feature: Arp
  Background:
    Given I use the fixture "arp"

  Scenario: read an ARP request packet
    When I create a packet with:
      """ruby
      Pio::Arp.read(eval(IO.read('arp_request.rb')))
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

  Scenario: read an ARP reply packet
    When I create a packet with:
      """ruby
      Pio::Arp.read(eval(IO.read('arp_reply.rb')))
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
