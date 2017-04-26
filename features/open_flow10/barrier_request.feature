@open_flow10
Feature: Barrier::Request

  When the controller wants to ensure message dependencies have been
  met or wants to receive notifications for completed operations, it
  may use an Barrier Request message. This message has no body.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Barrier::Request.new
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     1 |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |

  Scenario: new(transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::Barrier::Request.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     1 |
      | transaction_id |   123 |
      | xid            |   123 |
      | body           |       |
