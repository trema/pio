@open_flow10
Feature: TableStats::Request

  Information about tables is requested with a Table Stats Request
  message.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::TableStats::Request.new
      """
    Then the message has the following fields and values:
      | field          |  value |
      | version        |      1 |
      | transaction_id |      0 |
      | xid            |      0 |
      | stats_type     | :table |

  Scenario: new(transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::TableStats::Request.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          |  value |
      | version        |      1 |
      | transaction_id |    123 |
      | xid            |    123 |
      | stats_type     | :table |
