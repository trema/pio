@open_flow10
Feature: Features::Request

  Upon OpenFlow channel establishment, the controller sends a
  Features::Request message.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Features::Request.new
      """
    Then the message has the following fields and values:
      | field          | value |
      | transaction_id |     0 |
      | xid            |     0 |
      
  Scenario: new(transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::Features::Request.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | transaction_id |   123 |
      | xid            |   123 |
