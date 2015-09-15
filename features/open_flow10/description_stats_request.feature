@open_flow10
Feature: Pio::DescriptionStats::Request
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::DescriptionStats::Request.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |        value |
      | ofp_version    |            1 |
      | message_type   |           16 |
      | message_length |           12 |
      | transaction_id |            0 |
      | xid            |            0 |
      | stats_type     | :description |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::DescriptionStats::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |        value |
      | ofp_version    |            1 |
      | message_type   |           16 |
      | message_length |           12 |
      | transaction_id |          123 |
      | xid            |          123 |
      | stats_type     | :description |

  Scenario: read
    When I try to parse a file named "open_flow10/description_stats_request.raw" with "DescriptionStats::Request" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |        value |
      | ofp_version    |            1 |
      | message_type   |           16 |
      | message_length |           12 |
      | transaction_id |           12 |
      | xid            |           12 |
      | stats_type     | :description |
