Feature: Pio::Hello
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |          8 |
      | transaction_id |          0 |
      | xid            |          0 |
      | body           |            |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |          8 |
      | transaction_id |        123 |
      | xid            |        123 |
      | body           |            |

  Scenario: new(xid: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(xid: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |          8 |
      | transaction_id |        123 |
      | xid            |        123 |
      | body           |            |

  Scenario: new(xid: -1) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(xid: -1)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: new(xid: 2**32) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(xid: 2**32)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: new(body: 'hello')
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(body: 'hello')
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |         13 |
      | transaction_id |          0 |
      | xid            |          0 |
      | body           |      hello |

  Scenario: read
    When I try to parse a file named "open_flow10/hello.raw" with "Hello" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |          8 |
      | transaction_id |         23 |
      | xid            |         23 |
      | body           |            |

  Scenario: parse error
    When I try to parse a file named "open_flow10/features_request.raw" with "Pio::Hello" class
    Then it should fail with "Pio::ParseError", "Invalid Hello message."
