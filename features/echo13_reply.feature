Feature: OpenFlow 1.3 Echo Reply message
  Scenario: create
    When I create an OpenFlow message with "Pio::Echo13::Reply.new"
    Then the message have the following field and value:
      | field          |              value |
      | class          | Pio::Echo13::Reply |
      | ofp_version    |                  4 |
      | message_type   |                  3 |
      | message_length |                  8 |
      | transaction_id |                  0 |
      | xid            |                  0 |
      | body           |                    |

  Scenario: create (transaction_id: 123)
    When I create an OpenFlow message with "Pio::Echo13::Reply.new(transaction_id: 123)"
    Then the message have the following field and value:
        | field          |              value |
        | class          | Pio::Echo13::Reply |
        | ofp_version    |                  4 |
        | message_type   |                  3 |
        | message_length |                  8 |
        | transaction_id |                123 |
        | xid            |                123 |
        | body           |                    |

  Scenario: create (xid: 123)
    When I create an OpenFlow message with "Pio::Echo13::Reply.new(xid: 123)"
    Then the message have the following field and value:
        | field          |              value |
        | class          | Pio::Echo13::Reply |
        | ofp_version    |                  4 |
        | message_type   |                  3 |
        | message_length |                  8 |
        | transaction_id |                123 |
        | xid            |                123 |
        | body           |                    |

  Scenario: create (body: 'echo reply body')
    When I create an OpenFlow message with "Pio::Echo13::Reply.new(body: 'echo reply body')"
    Then the message have the following field and value:
        | field          |              value |
        | class          | Pio::Echo13::Reply |
        | ofp_version    |                  4 |
        | message_type   |                  3 |
        | message_length |                 23 |
        | transaction_id |                  0 |
        | xid            |                  0 |
        | body           |    echo reply body |

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
