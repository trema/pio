Feature: Parser
  Scenario: parse icmpv6.pcap
    When I parse a file named "icmpv6.pcap" with "Pio::Parser" class
    Then the message #1 have the following fields and values:
      | field           | value              |
      | class           | Pio::EthernetFrame |
      | destination_mac | 00:60:97:07:69:ea  |
      | source_mac      | 00:00:86:05:80:da  |
      | ether_type      | 34525              |
