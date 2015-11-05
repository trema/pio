Feature: Pio::ExactMatch
  Scenario: new (from ARP request Packet In)
    When I create an exact match from "open_flow10/packet_in_arp_request.raw"
    Then the message has the following fields and values:
      | field                      |             value |
      | wildcards                  |                {} |
      | in_port                    |                 1 |
      | source_mac_address         | ac:5d:10:31:37:79 |
      | destination_mac_address    | ff:ff:ff:ff:ff:ff |
      | vlan_vid                   |             65535 |
      | vlan_priority              |                 0 |
      | ether_type                 |              2054 |
      | tos                        |                 0 |
      | ip_protocol                |                 1 |
      | source_ip_address          |     192.168.2.254 |
      | destination_ip_address     |       192.168.2.5 |
      | transport_source_port      |                 0 |
      | transport_destination_port |                 0 |

  Scenario: new (from ARP reply Packet In)
    When I create an exact match from "open_flow10/packet_in_arp_reply.raw"
    Then the message has the following fields and values:
      | field                      |             value |
      | wildcards                  |                {} |
      | in_port                    |                 1 |
      | source_mac_address         | 11:11:11:11:11:11 |
      | destination_mac_address    | 22:22:22:22:22:22 |
      | vlan_vid                   |             65535 |
      | vlan_priority              |                 0 |
      | ether_type                 |              2054 |
      | tos                        |                 0 |
      | ip_protocol                |                 2 |
      | source_ip_address          |       192.168.0.1 |
      | destination_ip_address     |       192.168.0.2 |
      | transport_source_port      |                 0 |
      | transport_destination_port |                 0 |

  Scenario: new (from Cbench Packet In)
    When I create an exact match from "open_flow10/packet_in_cbench.raw"
    Then the message has the following fields and values:
      | field                      |             value |
      | wildcards                  |                {} |
      | in_port                    |                 1 |
      | source_mac_address         | 00:00:00:00:00:01 |
      | destination_mac_address    | 80:00:00:00:00:01 |
      | vlan_vid                   |             65535 |
      | vlan_priority              |                 0 |
      | ether_type                 |              2048 |
      | tos                        |                 0 |
      | ip_protocol                |               255 |
      | source_ip_address          |      192.168.0.40 |
      | destination_ip_address     |      192.168.1.40 |
      | transport_source_port      |             31256 |
      | transport_destination_port |             22635 |
