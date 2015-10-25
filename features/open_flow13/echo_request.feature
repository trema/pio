@open_flow13
Feature: Pio::Echo::Request
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     4 |
      | message_type   |     2 |
      | message_length |     8 |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |
      | user_data      |       |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     4 |
      | message_type   |     2 |
      | message_length |     8 |
      | transaction_id |   123 |
      | xid            |   123 |
      | body           |       |
      | user_data      |       |

  Scenario: new(body: 'echo request body')
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new(body: 'echo request body')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |             value |
      | ofp_version    |                 4 |
      | message_type   |                 2 |
      | message_length |                25 |
      | transaction_id |                 0 |
      | xid            |                 0 |
      | body           | echo request body |
      | user_data      | echo request body |

  Scenario: new(unknown_attr: 'foo') and error
    When I try to create an OpenFlow message with:
      """
      Pio::Echo::Request.new(unknown_attr: 'foo')
      """
    Then it should fail with "RuntimeError", "Unknown option: unknown_attr"

  Scenario: read (no message body)
    When I try to parse a file named "open_flow13/echo_request_no_body.raw" with "Pio::Echo::Request" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     4 |
      | message_type   |     2 |
      | message_length |     8 |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |
      | user_data      |       |

  Scenario: read
    When I try to parse a file named "open_flow13/echo_request_body.raw" with "Pio::Echo::Request" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |                value |
      | ofp_version    |                    4 |
      | message_type   |                    2 |
      | message_length |                   28 |
      | transaction_id |                    0 |
      | xid            |                    0 |
      | body           | hogehogehogehogehoge |
      | user_data      | hogehogehogehogehoge |

  Scenario: parse error
    When I try to parse a file named "open_flow10/features_request.raw" with "Pio::Echo::Request" class
    Then it should fail with "Pio::ParseError", "Invalid OpenFlow13 Echo Request message."
