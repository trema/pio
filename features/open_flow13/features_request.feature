Feature: Pio::Features::Request
  Background:
    Given I use OpenFlow 1.3

  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                  value |
      | class          | Pio::Features::Request |
      | ofp_version    |                      4 |
      | message_type   |                      5 |
      | message_length |                      8 |
      | transaction_id |                      0 |
      | xid            |                      0 |
      | body           |                        |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                  value |
      | class          | Pio::Features::Request |
      | ofp_version    |                      4 |
      | message_type   |                      5 |
      | message_length |                      8 |
      | transaction_id |                    123 |
      | xid            |                    123 |
      | body           |                        |

  Scenario: new(xid: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new(xid: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                  value |
      | class          | Pio::Features::Request |
      | ofp_version    |                      4 |
      | message_type   |                      5 |
      | message_length |                      8 |
      | transaction_id |                    123 |
      | xid            |                    123 |
      | body           |                        |

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

  Scenario: new(unknown_attr: 'foo') and error
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new(unknown_attr: 'foo')
      """
    Then it should fail with "RuntimeError", "Unknown keyword: unknown_attr"

  Scenario: read
    When I try to parse a file named "features_request13.raw" with "Pio::Features::Request" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |                  value |
      | class          | Pio::Features::Request |
      | ofp_version    |                      4 |
      | message_type   |                      5 |
      | message_length |                      8 |
      | transaction_id |                      0 |
      | xid            |                      0 |
      | body           |                        |

  Scenario: parse error
    When I try to parse a file named "hello.raw" with "Pio::Features::Request" class
    Then it should fail with "Pio::ParseError", "Invalid Features Request 1.3 message."
