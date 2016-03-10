@open_flow10
Feature: Hello

  Hello messages are exchanged between the switch and controller upon
  connection startup. Hello messages have the version field set to the
  highest OpenFlow protocol version supported by the sender.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Hello.new
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     1 |
      | transaction_id |     0 |
      | xid            |     0 |

  Scenario: new(transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::Hello.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     1 |
      | transaction_id |   123 |
      | xid            |   123 |
