Feature: Pio::Features::Reply
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Reply.new(
        dpid: 0x123,
        n_buffers: 0x100,
        n_tables: 0xfe,
        capabilities: [:flow_stats, :table_stats, :port_stats, :queue_stats,
                       :arp_match_ip],
        actions: [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan,
                  :set_ether_source_address, :set_ether_destination_address, :set_ip_source_address, :set_ip_destination_address,
                  :set_ip_tos, :set_transport_source_port, :set_transport_destination_port, :enqueue],
        ports: [{ port_no: 1,
                  hardware_address: '11:22:33:44:55:66',
                  name: 'port123',
                  config: [:port_down],
                  state: [:link_down],
                  curr: [:port_10gb_fd, :port_copper] }]
      )
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field                        |                                                                                                                                                                                                                              value |
      | class                        |                                                                                                                                                                                                               Pio::Features::Reply |
      | ofp_version                  |                                                                                                                                                                                                                                  1 |
      | message_type                 |                                                                                                                                                                                                                                  6 |
      | message_length               |                                                                                                                                                                                                                                 80 |
      | transaction_id               |                                                                                                                                                                                                                                  0 |
      | xid                          |                                                                                                                                                                                                                                  0 |
      | datapath_id                  |                                                                                                                                                                                                                                291 |
      | dpid                         |                                                                                                                                                                                                                                291 |
      | n_buffers                    |                                                                                                                                                                                                                                256 |
      | n_tables                     |                                                                                                                                                                                                                                254 |
      | capabilities                 |                                                                                                                                                              [:flow_stats, :table_stats, :port_stats, :queue_stats, :arp_match_ip] |
      | actions                      | [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan, :set_ether_source_address, :set_ether_destination_address, :set_ip_source_address, :set_ip_destination_address, :set_ip_tos, :set_transport_source_port, :set_transport_destination_port, :enqueue] |
      | ports.length                 |                                                                                                                                                                                                                                  1 |
      | ports.first.datapath_id      |                                                                                                                                                                                                                                291 |
      | ports.first.port_no          |                                                                                                                                                                                                                                  1 |
      | ports.first.mac_address      |                                                                                                                                                                                                                  11:22:33:44:55:66 |
      | ports.first.hardware_address |                                                                                                                                                                                                                  11:22:33:44:55:66 |
      | ports.first.name             |                                                                                                                                                                                                                            port123 |
      | ports.first.config           |                                                                                                                                                                                                                       [:port_down] |
      | ports.first.state            |                                                                                                                                                                                                                       [:link_down] |
      | ports.first.curr             |                                                                                                                                                                                                      [:port_10gb_fd, :port_copper] |
      | ports.first.advertised       |                                                                                                                                                                                                                                 [] |
      | ports.first.supported        |                                                                                                                                                                                                                                 [] |
      | ports.first.peer             |                                                                                                                                                                                                                                 [] |

  Scenario: read
    When I try to parse a file named "features_reply.raw" with "Features::Reply" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                        | value                                                                                                                                                                                                                              |
      | class                        | Pio::Features::Reply                                                                                                                                                                                                               |
      | ofp_version                  | 1                                                                                                                                                                                                                                  |
      | message_type                 | 6                                                                                                                                                                                                                                  |
      | message_length               | 176                                                                                                                                                                                                                                |
      | transaction_id               | 2                                                                                                                                                                                                                                  |
      | xid                          | 2                                                                                                                                                                                                                                  |
      | datapath_id                  | 1                                                                                                                                                                                                                                  |
      | dpid                         | 1                                                                                                                                                                                                                                  |
      | n_buffers                    | 256                                                                                                                                                                                                                                |
      | n_tables                     | 1                                                                                                                                                                                                                                  |
      | capabilities                 | [:flow_stats, :table_stats, :port_stats, :arp_match_ip]                                                                                                                                                                            |
      | actions                      | [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan, :set_ether_source_address, :set_ether_destination_address, :set_ip_source_address, :set_ip_destination_address, :set_ip_tos, :set_transport_source_port, :set_transport_destination_port, :enqueue] |
      | ports.length                 | 3                                                                                                                                                                                                                                  |
      | ports.first.datapath_id      | 1                                                                                                                                                                                                                                  |
      | ports.first.port_no          | 2                                                                                                                                                                                                                                  |
      | ports.first.mac_address      | 16:7d:a4:37:ba:10                                                                                                                                                                                                                  |
      | ports.first.hardware_address | 16:7d:a4:37:ba:10                                                                                                                                                                                                                  |
      | ports.first.name             | trema0-0                                                                                                                                                                                                                           |
      | ports.first.config           | []                                                                                                                                                                                                                                 |
      | ports.first.state            | []                                                                                                                                                                                                                                 |
      | ports.first.curr             | [:port_10gb_fd, :port_copper]                                                                                                                                                                                                      |
      | ports.first.advertised       | []                                                                                                                                                                                                                                 |
      | ports.first.supported        | []                                                                                                                                                                                                                                 |
      | ports.first.peer             | []                                                                                                                                                                                                                                 |
      | ports.last.port_no           | 1                                                                                                                                                                                                                                  |
      | ports.last.number            | 1                                                                                                                                                                                                                                  |
      | ports.last.mac_address       | 62:94:3a:f6:40:db                                                                                                                                                                                                                  |
      | ports.last.hardware_address  | 62:94:3a:f6:40:db                                                                                                                                                                                                                  |
      | ports.last.name              | trema1-0                                                                                                                                                                                                                           |
      | ports.last.config            | []                                                                                                                                                                                                                                 |
      | ports.last.state             | []                                                                                                                                                                                                                                 |
      | ports.last.curr              | [:port_10gb_fd, :port_copper]                                                                                                                                                                                                      |
      | ports.last.advertised        | []                                                                                                                                                                                                                                 |
      | ports.last.supported         | []                                                                                                                                                                                                                                 |
      | ports.last.peer              | []                                                                                                                                                                                                                                 |
      | ports.last.up?               | true                                                                                                                                                                                                                               |
      | ports.last.down?             | false                                                                                                                                                                                                                              |
      | ports.last.local?            | false                                                                                                                                                                                                                              |

  Scenario: parse error
    When I try to parse a file named "echo_reply.raw" with "Pio::Features::Reply" class
    Then it should fail with "Pio::ParseError", "Invalid Features Reply message."
