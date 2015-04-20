Feature: Features Reply
  Background:
    Given I use OpenFlow 1.3

  Scenario: read
    When I try to parse a file named "features_reply13.raw" with "Pio::Features::Reply" class
    Then it should finish successfully
    And the message have the following fields and values:
    | field          |                                                                                          value |
    | class          |                                                                           Pio::Features::Reply |
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
