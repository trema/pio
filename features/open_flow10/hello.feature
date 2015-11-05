@open_flow10
Feature: Pio::Hello

  Hello messages are exchanged between the switch and controller upon
  connection startup.

  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow10::Hello.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |     0 |
      | message_length |     8 |
      | transaction_id |     0 |
      | xid            |     0 |
      | body           |       |
      | user_data      |       |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |     0 |
      | message_length |     8 |
      | transaction_id |   123 |
      | xid            |   123 |
      | body           |       |
      | user_data      |       |
      
  Scenario: read
    When I try to parse a file named "open_flow10/hello.raw" with "Hello" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |     0 |
      | message_length |     8 |
      | transaction_id |    23 |
      | xid            |    23 |
      | body           |       |
      | user_data      |       |
