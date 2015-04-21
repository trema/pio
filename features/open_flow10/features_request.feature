Feature: Pio::Features::Request
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new
      """
    Then it should finish successfully
    And the message have the following fields and values:
    | field          |                  value |
    | class          | Pio::Features::Request |
    | ofp_version    |                      1 |
    | message_type   |                      5 |
    | message_length |                      8 |
    | transaction_id |                      0 |
    | xid            |                      0 |
    | user_data      |                        |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                  value |
      | class          | Pio::Features::Request |
      | ofp_version    |                      1 |
      | message_type   |                      5 |
      | message_length |                      8 |
      | transaction_id |                    123 |
      | xid            |                    123 |
      | user_data      |                        |

  Scenario: new(xid: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new(xid: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                  value |
      | class          | Pio::Features::Request |
      | ofp_version    |                      1 |
      | message_type   |                      5 |
      | message_length |                      8 |
      | transaction_id |                    123 |
      | xid            |                    123 |
      | user_data      |                        |

  Scenario: new(xid: -1) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new(xid: -1)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: new(xid: 2**32) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new(xid: 2**32)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: read
    When I try to parse a file named "features_request.raw" with "Pio::Features::Request" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                  value |
      | class          | Pio::Features::Request |
      | ofp_version    |                      1 |
      | message_type   |                      5 |
      | message_length |                      8 |
      | transaction_id |                      2 |
      | xid            |                      2 |
      | user_data      |                        |

  Scenario: parse error
    When I try to parse a file named "echo_request.raw" with "Pio::Features::Request" class
    Then it should fail with "Pio::ParseError", "Invalid Features Request message."
