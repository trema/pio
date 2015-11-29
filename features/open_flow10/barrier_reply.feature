@open_flow10
Feature: Barrier::Reply

  When the switch received a Barrier Request message, the switch must
  finish processing all previously-received messages before executing
  any messages beyond the Barrier Request. When such processing is
  complete, the switch must send an Barrier Reply message with the xid
  of the original request.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Barrier::Reply.new
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
      Pio::Barrier::Reply.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     1 |
      | transaction_id |   123 |
      | xid            |   123 |
      | body           |       |
