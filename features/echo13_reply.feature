Feature: OpenFlow 1.3 Echo Reply message
  Scenario: create
    When I try to create an OpenFlow message with "Pio::Echo13::Reply.new"
    Then it should finish successfully
    And the message have the following field and value:
      | field          |              value |
      | class          | Pio::Echo13::Reply |
      | ofp_version    |                  4 |
      | message_type   |                  3 |
      | message_length |                  8 |
      | transaction_id |                  0 |
      | xid            |                  0 |
      | body           |                    |

  Scenario: create (transaction_id: 123)
    When I try to create an OpenFlow message with "Pio::Echo13::Reply.new(transaction_id: 123)"
    Then it should finish successfully
    And the message have the following field and value:
        | field          |              value |
        | class          | Pio::Echo13::Reply |
        | ofp_version    |                  4 |
        | message_type   |                  3 |
        | message_length |                  8 |
        | transaction_id |                123 |
        | xid            |                123 |
        | body           |                    |

  Scenario: create (xid: 123)
    When I try to create an OpenFlow message with "Pio::Echo13::Reply.new(xid: 123)"
    Then it should finish successfully
    And the message have the following field and value:
        | field          |              value |
        | class          | Pio::Echo13::Reply |
        | ofp_version    |                  4 |
        | message_type   |                  3 |
        | message_length |                  8 |
        | transaction_id |                123 |
        | xid            |                123 |
        | body           |                    |

  Scenario: create (xid: -1) and error
    When I try to create an OpenFlow message with "Pio::Echo13::Reply.new(xid: -1)"
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: create (xid: 2**32) and error
    When I try to create an OpenFlow message with "Pio::Echo13::Reply.new(xid: 2**32)"
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: create (body: 'echo reply body')
    When I try to create an OpenFlow message with "Pio::Echo13::Reply.new(body: 'echo reply body')"
    Then it should finish successfully
    And the message have the following field and value:
        | field          |              value |
        | class          | Pio::Echo13::Reply |
        | ofp_version    |                  4 |
        | message_type   |                  3 |
        | message_length |                 23 |
        | transaction_id |                  0 |
        | xid            |                  0 |
        | body           |    echo reply body |

  Scenario: create (unknown_attr: 'foo') and error
    When I try to create an OpenFlow message with "Pio::Echo13::Reply.new(unknown_attr: 'foo')"
    Then it should fail with "RuntimeError", "Unknown keyword: unknown_attr"

  Scenario: parse (no message body)
    Given a packet data file "echo13_reply_no_body.raw"
    When I try to parse the file with "Pio::Echo13::Reply" class
    Then it should finish successfully
    And the message have the following field and value:
      | field          |              value |
      | class          | Pio::Echo13::Reply |
      | ofp_version    |                  4 |
      | message_type   |                  3 |
      | message_length |                  8 |
      | transaction_id |                  0 |
      | xid            |                  0 |
      | body           |                    |

  Scenario: parse
    Given a packet data file "echo13_reply_body.raw"
    When I try to parse the file with "Pio::Echo13::Reply" class
    Then it should finish successfully
    And the message have the following field and value:
      | field          |                value |
      | class          |   Pio::Echo13::Reply |
      | ofp_version    |                    4 |
      | message_type   |                    3 |
      | message_length |                   28 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           | hogehogehogehogehoge |

  Scenario: parse error
    Given a packet data file "features_request.raw"
    When I try to parse the file with "Pio::Echo13::Reply" class
    Then it should fail with "Pio::ParseError", "Invalid Echo Reply 1.3 message."
