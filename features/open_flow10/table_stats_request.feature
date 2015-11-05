@open_flow10
Feature: Pio::TableStats::Request
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::TableStats::Request.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |  value |
      | ofp_version    |      1 |
      | message_type   |     16 |
      | message_length |     12 |
      | transaction_id |      0 |
      | xid            |      0 |
      | stats_type     | :table |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::TableStats::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |  value |
      | ofp_version    |      1 |
      | message_type   |     16 |
      | message_length |     12 |
      | transaction_id |    123 |
      | xid            |    123 |
      | stats_type     | :table |
