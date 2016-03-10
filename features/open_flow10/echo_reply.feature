@open_flow10
Feature: Echo::Reply

  An Echo Reply message consists of an OpenFlow header plus the
  unmodified data field of an echo request message.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Echo::Reply.new
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
      Pio::Echo::Reply.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | transaction_id |   123 |
      | xid            |   123 |
      | body           |       |
      | user_data      |       |

  Scenario: new(body: 'echo reply body')
    When I create an OpenFlow message with:
      """
      Pio::Echo::Reply.new(body: 'echo reply body')
      """
    Then the message has the following fields and values:
      | field          | value           |
      | transaction_id | 0               |
      | xid            | 0               |
      | body           | echo reply body |
      | user_data      | echo reply body |
