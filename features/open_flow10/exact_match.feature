Feature: Exact Match
  Scenario: parse #1
    When I create an exact match from "packet_in_arp_request.raw"
    And the message have the following fields and values:
      | field                  |             value |
      | wildcards              |                {} |
      | in_port                |                 1 |
      | ether_source_addr      | ac:5d:10:31:37:79 |
      | ether_destination_addr | ff:ff:ff:ff:ff:ff |
      | dl_vlan                |             65535 |
      | dl_vlan_pcp            |                 0 |
      | ether_type             |              2054 |
      | nw_tos                 |                 0 |
      | nw_proto               |                 1 |
      | ip_source_address      |     192.168.2.254 |
      | ip_destination_address |       192.168.2.5 |
      | tp_source              |                 0 |
      | tp_destination         |                 0 |

  Scenario: parse #2
    When I create an exact match from "packet_in_cbench.raw"
    And the message have the following fields and values:
      | field                  |             value |
      | wildcards              |                {} |
      | in_port                |                 1 |
      | ether_source_addr      | 00:00:00:00:00:01 |
      | ether_destination_addr | 80:00:00:00:00:01 |
      | dl_vlan                |             65535 |
      | dl_vlan_pcp            |                 0 |
      | ether_type             |              2048 |
      | nw_tos                 |                 0 |
      | nw_proto               |               255 |
      | ip_source_address      |      192.168.0.40 |
      | ip_destination_address |      192.168.1.40 |
      | tp_source              |             31256 |
      | tp_destination         |             22635 |
