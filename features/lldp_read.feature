Feature: Pio::Lldp.read
  Scenario: lldp.minimal.pcap
    Given a packet data file "lldp.minimal.pcap"
    When I try to parse the file with "Lldp" class
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

  Scenario: lldp.detailed.pcap
    Given a packet data file "lldp.detailed.pcap"
    When I try to parse the file with "Lldp" class
    Then it should finish successfully
