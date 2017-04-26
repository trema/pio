@open_flow13
Feature: Echo::Reply
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Echo::Reply.new
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     4 |
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
      | version        |     4 |
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
        | field          |           value |
        | version        |               4 |
        | transaction_id |               0 |
        | xid            |               0 |
        | body           | echo reply body |
        | user_data      | echo reply body |

  Scenario: read (no message body)
    When I parse a file named "open_flow13/echo_reply_no_body.raw" with "Pio::Echo::Reply" class
    Then the message has the following fields and values:
      | field          | value |
      | version        |     4 |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |
      | user_data      |       |

  Scenario: read
    When I parse a file named "open_flow13/echo_reply_body.raw" with "Pio::Echo::Reply" class
    Then the message has the following fields and values:
      | field          |                value |
      | version        |                    4 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           | hogehogehogehogehoge |
      | user_data      | hogehogehogehogehoge |
