@open_flow13
Feature: Features::Request
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Features::Request.new
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     4 |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |

  Scenario: new(transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::Features::Request.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     4 |
      | transaction_id |   123 |
      | xid            |   123 |
      | body           |       |
