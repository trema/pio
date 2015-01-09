Feature: Pio::Features.read
  Scenario: features_request.raw
    Given a packet data file "features_request.raw"
    When I try to parse the file with "Features" class
    Then it should finish successfully
    And the parsed data have the following field and value:
    | field          |                  value |
    | class          | Pio::Features::Request |
    | ofp_version    |                      1 |
    | message_type   |                      5 |
    | message_length |                      8 |
    | transaction_id |                      2 |
    | xid            |                      2 |
    | body           |                        |

  Scenario: features_reply.raw
    Given a packet data file "features_reply.raw"
    When I try to parse the file with "Features" class
    Then it should finish successfully
    And the parsed data have the following field and value:
    | field                        | value                                                                                                                                                     |
    | class                        | Pio::Features::Reply                                                                                                                                      |
    | ofp_version                  | 1                                                                                                                                                         |
    | message_type                 | 6                                                                                                                                                         |
    | message_length               | 176                                                                                                                                                       |
    | transaction_id               | 2                                                                                                                                                         |
    | xid                          | 2                                                                                                                                                         |
    | datapath_id                  | 1                                                                                                                                                         |
    | dpid                         | 1                                                                                                                                                         |
    | n_buffers                    | 256                                                                                                                                                       |
    | n_tables                     | 1                                                                                                                                                         |
    | capabilities                 | [:flow_stats, :table_stats, :port_stats, :arp_match_ip]                                                                                                   |
    | actions                      | [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan, :set_dl_src, :set_dl_dst, :set_nw_src, :set_nw_dst, :set_nw_tos, :set_tp_src, :set_tp_dst, :enqueue] |
    | ports.length                 | 3                                                                                                                                                         |
    | ports.first.port_no          | 2                                                                                                                                                         |
    | ports.first.mac_address      | 16:7d:a4:37:ba:10                                                                                                                                         |
    | ports.first.hardware_address | 16:7d:a4:37:ba:10                                                                                                                                         |
    | ports.first.name             | trema0-0                                                                                                                                                  |
    | ports.first.config           | []                                                                                                                                                        |
    | ports.first.state            | []                                                                                                                                                        |
    | ports.first.curr             | [:port_10gb_fd, :port_copper]                                                                                                                             |
    | ports.first.advertised       | []                                                                                                                                                        |
    | ports.first.supported        | []                                                                                                                                                        |
    | ports.first.peer             | []                                                                                                                                                        |
    | ports.last.port_no           | 1                                                                                                                                                         |
    | ports.last.mac_address       | 62:94:3a:f6:40:db                                                                                                                                         |
    | ports.last.hardware_address  | 62:94:3a:f6:40:db                                                                                                                                         |
    | ports.last.name              | trema1-0                                                                                                                                                  |
    | ports.last.config            | []                                                                                                                                                        |
    | ports.last.state             | []                                                                                                                                                        |
    | ports.last.curr              | [:port_10gb_fd, :port_copper]                                                                                                                             |
    | ports.last.advertised        | []                                                                                                                                                        |
    | ports.last.supported         | []                                                                                                                                                        |
    | ports.last.peer              | []                                                                                                                                                        |
