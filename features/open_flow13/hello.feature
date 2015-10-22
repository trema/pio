@open_flow13
Feature: Pio::Hello
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |          value |
      | ofp_version        |              4 |
      | message_type       |              0 |
      | message_length     |             16 |
      | transaction_id     |              0 |
      | xid                |              0 |
      | supported_versions | [:open_flow13] |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |          value |
      | ofp_version        |              4 |
      | message_type       |              0 |
      | message_length     |             16 |
      | transaction_id     |            123 |
      | xid                |            123 |
      | supported_versions | [:open_flow13] |

  Scenario: read (no version bitmap)
    When I try to parse a file named "open_flow13/hello_no_version_bitmap.raw" with "Pio::Hello" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field              | value |
      | ofp_version        |     4 |
      | message_type       |     0 |
      | message_length     |     8 |
      | transaction_id     |     0 |
      | xid                |     0 |
      | supported_versions |    [] |

  Scenario: read
    When I try to parse a file named "open_flow13/hello_version_bitmap.raw" with "Pio::Hello" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |                        value |
      | ofp_version        |                            4 |
      | message_type       |                            0 |
      | message_length     |                           16 |
      | transaction_id     |                            0 |
      | xid                |                            0 |
      | supported_versions | [:open_flow10, :open_flow13] |
