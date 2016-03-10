@open_flow10
Feature: Features::Reply
  Scenario: new
    When I create an OpenFlow message with:
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
    Then the message has the following fields and values:
      | field                     |                                                                 value |
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
      | ports[0].port_number      |                                                                     1 |
      | ports[0].mac_address      |                                                     11:22:33:44:55:66 |
      | ports[0].hardware_address |                                                     11:22:33:44:55:66 |
      | ports[0].name             |                                                               port123 |
      | ports[0].config           |                                                          [:port_down] |
      | ports[0].state            |                                                          [:link_down] |
      | ports[0].curr             |                                         [:port_10gb_fd, :port_copper] |
      | ports[0].advertised       |                                                                    [] |
      | ports[0].supported        |                                                                    [] |
      | ports[0].peer             |                                                                    [] |
