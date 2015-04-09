Feature: Pio::ExactMatch.new
  Scenario: packet_in_arp_request.raw 
    When I create an exact match from "packet_in_arp_request.raw"
    And the message have the following fields and values:
      | field       |             value |
      | wildcards   |                {} |
      | in_port     |                 1 |
      | dl_src      | ac:5d:10:31:37:79 |
      | dl_dst      | ff:ff:ff:ff:ff:ff |
      | dl_vlan     |             65535 |
      | dl_vlan_pcp |                 0 |
      | dl_type     |              2054 |
      | nw_tos      |                 0 |
      | nw_proto    |                 1 |
      | nw_src      |     192.168.2.254 |
      | nw_dst      |       192.168.2.5 |
      | tp_src      |                 0 |
      | tp_dst      |                 0 |

  Scenario: packet_in_cbench.raw (ARP request)
    When I create an exact match from "packet_in_cbench.raw"
    And the message have the following fields and values:
      | field       |             value |
      | wildcards   |                {} |
      | in_port     |                 1 |
      | dl_src      | 00:00:00:00:00:01 |
      | dl_dst      | 80:00:00:00:00:01 |
      | dl_vlan     |             65535 |
      | dl_vlan_pcp |                 0 |
      | dl_type     |              2048 |
      | nw_tos      |                 0 |
      | nw_proto    |               255 |
      | nw_src      |      192.168.0.40 |
      | nw_dst      |      192.168.1.40 |
      | tp_src      |             31256 |
      | tp_dst      |             22635 |
