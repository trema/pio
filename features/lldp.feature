Feature: Pio::Lldp
  Scenario: create
    When I try to create an OpenFlow message with:
      """
      Pio::Lldp.new(dpid: 0x123, port_number: 12, source_mac: '11:22:33:44:55:66')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                     |             value |
      | class                     |         Pio::Lldp |
      | destination_mac           | 01:80:c2:00:00:0e |
      | source_mac                | 11:22:33:44:55:66 |
      | ether_type                |             35020 |
      | chassis_id                |               291 |
      | dpid                      |               291 |
      | port_id                   |                12 |
      | ttl                       |               120 |
      | port_description          |                   |
      | system_name               |                   |
      | system_description        |                   |
      | system_capabilities       |                   |
      | management_address        |                   |
      | organizationally_specific |                   |

  Scenario: parse lldp.minimal.pcap
    When I try to parse a file named "lldp.minimal.pcap" with "Pio::Lldp" class
    Then it should finish successfully
    Then the message #1 have the following fields and values:
      | field                     | value             |
      | class                     | Pio::Lldp         |
      | destination_mac           | 01:80:c2:00:00:0e |
      | source_mac                | 00:04:96:1f:a7:26 |
      | ether_type                | 35020             |
      | chassis_id                | 19698525990       |
      | dpid                      | 19698525990       |
      | port_id                   | 1/3               |
      | ttl                       | 120               |
      | port_description          |                   |
      | system_name               |                   |
      | system_description        |                   |
      | system_capabilities       |                   |
      | management_address        |                   |
      | organizationally_specific |                   |

  Scenario: parse lldp.detailed.pcap
    When I try to parse a file named "lldp.detailed.pcap" with "Pio::Lldp" class
    Then it should finish successfully
