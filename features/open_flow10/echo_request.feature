Feature: Echo Request
  Scenario: create
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |              value |
      | class          | Pio::Echo::Request |
      | ofp_version    |                  1 |
      | message_type   |                  2 |
      | message_length |                  8 |
      | transaction_id |                  0 |
      | xid            |                  0 |
      | user_data      |                    |

  Scenario: create (transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |              value |
      | class          | Pio::Echo::Request |
      | ofp_version    |                  1 |
      | message_type   |                  2 |
      | message_length |                  8 |
      | transaction_id |                123 |
      | xid            |                123 |
      | user_data      |                    |

  Scenario: create (xid: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new(xid: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |              value |
      | class          | Pio::Echo::Request |
      | ofp_version    |                  1 |
      | message_type   |                  2 |
      | message_length |                  8 |
      | transaction_id |                123 |
      | xid            |                123 |
      | user_data      |                    |

  Scenario: create (xid: -1) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new(xid: -1)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: create (xid: 2**32) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new(xid: 2**32)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: create (user_data: 'echo request body')
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new(user_data: 'echo request body')
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |              value |
      | class          | Pio::Echo::Request |
      | ofp_version    |                  1 |
      | message_type   |                  2 |
      | message_length |                 25 |
      | transaction_id |                  0 |
      | xid            |                  0 |
      | user_data      |  echo request body |

  Scenario: parse (no message body)
    When I try to parse a file named "echo_request.raw" with "Pio::Echo::Request" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |              value |
      | class          | Pio::Echo::Request |
      | ofp_version    |                  1 |
      | message_type   |                  2 |
      | message_length |                  8 |
      | transaction_id |                  0 |
      | xid            |                  0 |
      | user_data      |                    |

  Scenario: parse error
    When I try to parse a file named "features_request.raw" with "Pio::Echo::Request" class
    Then it should fail with "Pio::ParseError", "Invalid Echo Request message."
