@open_flow10
Feature: Echo::Request

  An Echo Request message consists of an OpenFlow header plus an
  arbitrary-length data field. The data field might be a message
  timestamp to check latency, various lengths to measure bandwidth, or
  zero-size to verify liveness between the switch and controller.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Echo::Request.new
      """
    Then the message has the following fields and values:
      | field          | value |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |
      | user_data      |       |

  Scenario: new(transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::Echo::Request.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | transaction_id |   123 |
      | xid            |   123 |
      | body           |       |
      | user_data      |       |

  Scenario: new(body: 'echo request body')
    When I create an OpenFlow message with:
      """
      Pio::Echo::Request.new(body: 'echo request body')
      """
    Then the message has the following fields and values:
      | field          | value             |
      | transaction_id | 0                 |
      | xid            | 0                 |
      | body           | echo request body |
      | user_data      | echo request body |
