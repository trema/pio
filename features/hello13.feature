Feature: OpenFlow 1.3 Hello message
  Scenario: create
    When I create an OpenFlow message with "Pio::Hello13.new"
    Then the message have the following field and value:
      | field              |          value |
      | class              |   Pio::Hello13 |
      | ofp_version        |              4 |
      | message_type       |              0 |
      | message_length     |             16 |
      | transaction_id     |              0 |
      | xid                |              0 |
      | supported_versions | [:open_flow13] |

  Scenario: create (transaction_id: 123)
    When I create an OpenFlow message with "Pio::Hello13.new(transaction_id: 123)"
    Then the message have the following field and value:
      | field              |          value |
      | class              |   Pio::Hello13 |
      | ofp_version        |              4 |
      | message_type       |              0 |
      | message_length     |             16 |
      | transaction_id     |            123 |
      | xid                |            123 |
      | supported_versions | [:open_flow13] |

  Scenario: create (xid: 123)
    When I create an OpenFlow message with "Pio::Hello13.new(xid: 123)"
    Then the message have the following field and value:
      | field              |          value |
      | class              |   Pio::Hello13 |
      | ofp_version        |              4 |
      | message_type       |              0 |
      | message_length     |             16 |
      | transaction_id     |            123 |
      | xid                |            123 |
      | supported_versions | [:open_flow13] |

  Scenario: parse (no version bitmap)
    Given a packet data file "hello13_no_version_bitmap.raw"
    When I try to parse the file with "Hello13" class
    Then it should finish successfully
    And the message have the following field and value:
      | field              |        value |
      | class              | Pio::Hello13 |
      | ofp_version        |            4 |
      | message_type       |            0 |
      | message_length     |            8 |
      | transaction_id     |            0 |
      | xid                |            0 |
      | supported_versions |           [] |

  Scenario: parse
    Given a packet data file "hello13_version_bitmap.raw"
    When I try to parse the file with "Hello13" class
    Then it should finish successfully
    And the message have the following field and value:
      | field              |                        value |
      | class              |                 Pio::Hello13 |
      | ofp_version        |                            4 |
      | message_type       |                            0 |
      | message_length     |                           16 |
      | transaction_id     |                            0 |
      | xid                |                            0 |
      | supported_versions | [:open_flow10, :open_flow13] |
