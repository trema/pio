@open_flow10
Feature: Pio::Features::Reply
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Reply.new(
        datapath_id: 0x123,
        n_buffers: 0x100,
        n_tables: 0xfe,
        capabilities: [:flow_stats, :table_stats, :port_stats, :queue_stats, :arp_match_ip],
        actions: [:output, :set_source_mac_address, :set_destination_mac_address],
        ports: [{ port_no: 1,
                  hardware_address: '11:22:33:44:55:66',
                  name: 'port123',
                  config: [:port_down],
                  state: [:link_down],
                  curr: [:port_10gb_fd, :port_copper] }]
      )
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                     |                                                                 value |
      | ofp_version               |                                                                     1 |
      | message_type              |                                                                     6 |
      | message_length            |                                                                    80 |
      | transaction_id            |                                                                     0 |
      | xid                       |                                                                     0 |
      | datapath_id               |                                                                   291 |
      | dpid                      |                                                                   291 |
      | n_buffers                 |                                                                   256 |
      | n_tables                  |                                                                   254 |
      | capabilities              | [:flow_stats, :table_stats, :port_stats, :queue_stats, :arp_match_ip] |
      | actions                   |      [:output, :set_source_mac_address, :set_destination_mac_address] |
      | ports.length              |                                                                     1 |
      | ports[0].datapath_id      |                                                                   291 |
      | ports[0].port_no          |                                                                     1 |
      | ports[0].mac_address      |                                                     11:22:33:44:55:66 |
      | ports[0].hardware_address |                                                     11:22:33:44:55:66 |
      | ports[0].name             |                                                               port123 |
      | ports[0].config           |                                                          [:port_down] |
      | ports[0].state            |                                                          [:link_down] |
      | ports[0].curr             |                                         [:port_10gb_fd, :port_copper] |
      | ports[0].advertised       |                                                                    [] |
      | ports[0].supported        |                                                                    [] |
      | ports[0].peer             |                                                                    [] |

  Scenario: read
    When I try to parse a file named "open_flow10/features_reply.raw" with "Features::Reply" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                     | value                                                                                                                                                                                                                                             |
      | ofp_version               | 1                                                                                                                                                                                                                                                 |
      | message_type              | 6                                                                                                                                                                                                                                                 |
      | message_length            | 176                                                                                                                                                                                                                                               |
      | transaction_id            | 2                                                                                                                                                                                                                                                 |
      | xid                       | 2                                                                                                                                                                                                                                                 |
      | datapath_id               | 1                                                                                                                                                                                                                                                 |
      | dpid                      | 1                                                                                                                                                                                                                                                 |
      | n_buffers                 | 256                                                                                                                                                                                                                                               |
      | n_tables                  | 1                                                                                                                                                                                                                                                 |
      | capabilities              | [:flow_stats, :table_stats, :port_stats, :arp_match_ip]                                                                                                                                                                                           |
      | actions                   | [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan, :set_source_mac_address, :set_destination_mac_address, :set_source_ip_address, :set_destination_ip_address, :set_tos, :set_transport_source_port, :set_transport_destination_port, :enqueue] |
      | ports.length              | 3                                                                                                                                                                                                                                                 |
      | ports[0].datapath_id      | 1                                                                                                                                                                                                                                                 |
      | ports[0].port_no          | 2                                                                                                                                                                                                                                                 |
      | ports[0].mac_address      | 16:7d:a4:37:ba:10                                                                                                                                                                                                                                 |
      | ports[0].hardware_address | 16:7d:a4:37:ba:10                                                                                                                                                                                                                                 |
      | ports[0].name             | trema0-0                                                                                                                                                                                                                                          |
      | ports[0].config           | []                                                                                                                                                                                                                                                |
      | ports[0].state            | []                                                                                                                                                                                                                                                |
      | ports[0].curr             | [:port_10gb_fd, :port_copper]                                                                                                                                                                                                                     |
      | ports[0].advertised       | []                                                                                                                                                                                                                                                |
      | ports[0].supported        | []                                                                                                                                                                                                                                                |
      | ports[0].peer             | []                                                                                                                                                                                                                                                |
      | ports[2].port_no          | 1                                                                                                                                                                                                                                                 |
      | ports[2].number           | 1                                                                                                                                                                                                                                                 |
      | ports[2].mac_address      | 62:94:3a:f6:40:db                                                                                                                                                                                                                                 |
      | ports[2].hardware_address | 62:94:3a:f6:40:db                                                                                                                                                                                                                                 |
      | ports[2].name             | trema1-0                                                                                                                                                                                                                                          |
      | ports[2].config           | []                                                                                                                                                                                                                                                |
      | ports[2].state            | []                                                                                                                                                                                                                                                |
      | ports[2].curr             | [:port_10gb_fd, :port_copper]                                                                                                                                                                                                                     |
      | ports[2].advertised       | []                                                                                                                                                                                                                                                |
      | ports[2].supported        | []                                                                                                                                                                                                                                                |
      | ports[2].peer             | []                                                                                                                                                                                                                                                |
      | ports[2].up?              | true                                                                                                                                                                                                                                              |
      | ports[2].down?            | false                                                                                                                                                                                                                                             |
      | ports[2].local?           | false                                                                                                                                                                                                                                             |
