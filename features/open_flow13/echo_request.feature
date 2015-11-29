@open_flow13
Feature: Echo::Request
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Echo::Request.new
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
      Pio::Echo::Request.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     4 |
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
      | field          |             value |
      | version        |                 4 |
      | transaction_id |                 0 |
      | xid            |                 0 |
      | body           | echo request body |
      | user_data      | echo request body |

  Scenario: read (no message body)
    When I parse a file named "open_flow13/echo_request_no_body.raw" with "Pio::Echo::Request" class
    Then the message has the following fields and values:
      | field          | value |
      | version        |     4 |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |
      | user_data      |       |

  Scenario: read
    When I parse a file named "open_flow13/echo_request_body.raw" with "Pio::Echo::Request" class
    Then the message has the following fields and values:
      | field          |                value |
      | version        |                    4 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           | hogehogehogehogehoge |
      | user_data      | hogehogehogehogehoge |
