@open_flow10
Feature: Pio::Features::Request
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |     5 |
      | message_length |     8 |
      | transaction_id |     0 |
      | xid            |     0 |
      | user_data      |       |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Features::Request.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |     5 |
      | message_length |     8 |
      | transaction_id |   123 |
      | xid            |   123 |
      | user_data      |       |

  Scenario: read
    When I try to parse a file named "open_flow10/features_request.raw" with "Pio::Features::Request" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |     5 |
      | message_length |     8 |
      | transaction_id |     2 |
      | xid            |     2 |
      | user_data      |       |
