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
      | user_data      |            |

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
      | user_data      |            |
      
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
      | user_data      |            |

  Scenario: new(unknown_attr: 'foo') and error
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(unknown_attr: 'foo')
      """
    Then it should fail with "RuntimeError", "Unknown option: unknown_attr"

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
      | user_data      |      hello |

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
      | user_data      |            |

  Scenario: parse error
    When I try to parse a file named "open_flow10/features_request.raw" with "Pio::Hello" class
    Then it should fail with "Pio::ParseError", "Invalid Hello message."
