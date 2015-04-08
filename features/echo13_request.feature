Feature: OpenFlow 1.3 Echo Request message
  Scenario: create
    When I create an OpenFlow message with "Pio::Echo13::Request.new"
    Then the message have the following field and value:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                    8 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           |                      |

  Scenario: create (transaction_id: 123)
    When I create an OpenFlow message with "Pio::Echo13::Request.new(transaction_id: 123)"
    Then the message have the following field and value:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                    8 |
      | transaction_id |                  123 |
      | xid            |                  123 |
      | body           |                      |

  Scenario: create (xid: 123)
    When I create an OpenFlow message with "Pio::Echo13::Request.new(xid: 123)"
    Then the message have the following field and value:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                    8 |
      | transaction_id |                  123 |
      | xid            |                  123 |
      | body           |                      |

  Scenario: create (body: 'echo request body')
    When I create an OpenFlow message with "Pio::Echo13::Request.new(body: 'echo request body')"
    Then the message have the following field and value:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                   25 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           |    echo request body |

  Scenario: parse (no message body)
    Given a packet data file "echo13_request_no_body.raw"
    When I try to parse the file with "Pio::Echo13::Request" class
    Then it should finish successfully
    And the message have the following field and value:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                    8 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           |                      |

  Scenario: parse
    Given a packet data file "echo13_request_body.raw"
    When I try to parse the file with "Pio::Echo13::Request" class
    Then it should finish successfully
    And the message have the following field and value:
      | field          |                value |
      | class          | Pio::Echo13::Request |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                   28 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           | hogehogehogehogehoge |

  Scenario: parse error
    Given a packet data file "features_request.raw"
    When I try to parse the file with "Pio::Echo13::Request" class
    Then it should fail with "Pio::ParseError", "Invalid Echo Request 1.3 message."
