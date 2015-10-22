@open_flow13
Feature: Pio::Features::Reply
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Reply.new(
        datapath_id: 0x123,
        n_buffers: 0x100,
        n_tables: 0xfe,
        capabilities: [:flow_stats, :table_stats, :port_stats, :group_stats, :ip_reasm, :queue_stats, :port_blocked]
      )
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |                                                                                          value |
      | ofp_version    |                                                                                              4 |
      | message_type   |                                                                                              6 |
      | message_length |                                                                                             32 |
      | transaction_id |                                                                                              0 |
      | xid            |                                                                                              0 |
      | datapath_id    |                                                                                            291 |
      | dpid           |                                                                                            291 |
      | n_buffers      |                                                                                            256 |
      | n_tables       |                                                                                            254 |
      | auxiliary_id   |                                                                                              0 |
      | capabilities   | [:flow_stats, :table_stats, :port_stats, :group_stats, :ip_reasm, :queue_stats, :port_blocked] |
      | reserved       |                                                                                              0 |
  
  Scenario: read
    When I try to parse a file named "open_flow13/features_reply.raw" with "Pio::Features::Reply" class
    Then it should finish successfully
    And the message has the following fields and values:
    | field          |                                                                                          value |
    | ofp_version    |                                                                                              4 |
    | message_type   |                                                                                              6 |
    | message_length |                                                                                             32 |
    | transaction_id |                                                                                              0 |
    | xid            |                                                                                              0 |
    | datapath_id    |                                                                                281474976710657 |
    | dpid           |                                                                                281474976710657 |
    | n_buffers      |                                                                                            256 |
    | n_tables       |                                                                                              1 |
    | auxiliary_id   |                                                                                              0 |
    | capabilities   | [:flow_stats, :table_stats, :port_stats, :group_stats, :ip_reasm, :queue_stats, :port_blocked] |
    | reserved       |                                                                                              0 |
