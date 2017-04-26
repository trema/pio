@open_flow10
Feature: DescriptionStats::Request

  Information about the switch manufacturer, hardware revision,
  software revision, serial number, and a description field is
  available by sending a Description Stats Request.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::DescriptionStats::Request.new
      """
    Then the message has the following fields and values:
      | field          |        value |
      | version        |            1 |
      | transaction_id |            0 |
      | xid            |            0 |
      | stats_type     | :description |

  Scenario: new(transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::DescriptionStats::Request.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          |        value |
      | version        |            1 |
      | transaction_id |          123 |
      | xid            |          123 |
      | stats_type     | :description |
