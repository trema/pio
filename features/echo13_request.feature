Feature: OpenFlow 1.3 Echo Request message
  Scenario: create
    When I try to create an OpenFlow message with:
      """
      Pio::Echo13::Request.new
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                    8 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           |                      |

  Scenario: create (transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Echo13::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                    8 |
      | transaction_id |                  123 |
      | xid            |                  123 |
      | body           |                      |

  Scenario: create (xid: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Echo13::Request.new(xid: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                    8 |
      | transaction_id |                  123 |
      | xid            |                  123 |
      | body           |                      |

  Scenario: create (xid: -1) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Echo13::Request.new(xid: -1)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: create (xid: 2**32) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Echo13::Request.new(xid: 2**32)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: create (body: 'echo request body')
    When I try to create an OpenFlow message with:
      """
      Pio::Echo13::Request.new(body: 'echo request body')
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                   25 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           |    echo request body |

  Scenario: create (unknown_attr: 'foo') and error
    When I try to create an OpenFlow message with:
      """
      Pio::Echo13::Request.new(unknown_attr: 'foo')
      """
    Then it should fail with "RuntimeError", "Unknown keyword: unknown_attr"

  Scenario: parse (no message body)
    When I try to parse a file named "echo13_request_no_body.raw" with "Pio::Echo13::Request" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                    8 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           |                      |

  Scenario: parse
    When I try to parse a file named "echo13_request_body.raw" with "Pio::Echo13::Request" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                   28 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           | hogehogehogehogehoge |

  Scenario: parse error
    When I try to parse a file named "features_request.raw" with "Pio::Echo13::Request" class
    Then it should fail with "Pio::ParseError", "Invalid Echo Request 1.3 message."
