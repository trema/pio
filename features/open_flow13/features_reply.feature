@open_flow13
Feature: Features::Reply
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Features::Reply.new(
        datapath_id: 0x123,
        n_buffers: 0x100,
        n_tables: 0xfe,
        capabilities: [:flow_stats, :table_stats, :port_stats, :group_stats, :ip_reasm, :queue_stats, :port_blocked]
      )
      """
    Then the message has the following fields and values:
      | field          |                                                                                          value |
      | version        |                                                                                              4 |
      | transaction_id |                                                                                              0 |
      | xid            |                                                                                              0 |
      | datapath_id    |                                                                                            291 |
      | dpid           |                                                                                            291 |
      | n_buffers      |                                                                                            256 |
      | n_tables       |                                                                                            254 |
      | auxiliary_id   |                                                                                              0 |
      | capabilities   | [:flow_stats, :table_stats, :port_stats, :group_stats, :ip_reasm, :queue_stats, :port_blocked] |
      | reserved       |                                                                                              0 |
