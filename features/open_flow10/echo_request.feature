@open_flow10
Feature: Pio::OpenFlow::Echo::Request
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow::Echo::Request.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |     2 |
      | message_length |     8 |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |
      | user_data      |       |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow::Echo::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |     2 |
      | message_length |     8 |
      | transaction_id |   123 |
      | xid            |   123 |
      | body           |       |
      | user_data      |       |

  Scenario: new(body: 'echo request body')
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow::Echo::Request.new(body: 'echo request body')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |             value |
      | ofp_version    |                 1 |
      | message_type   |                 2 |
      | message_length |                25 |
      | transaction_id |                 0 |
      | xid            |                 0 |
      | body           | echo request body |
      | user_data      | echo request body |
