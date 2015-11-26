@open_flow13
Feature: Hello
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow::Hello.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |          value |
      | ofp_version        |              4 |
      | message_type       |              0 |
      | message_length     |             16 |
      | transaction_id     |              0 |
      | xid                |              0 |
      | supported_versions | [:open_flow13] |

  Scenario: new(transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow::Hello.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |          value |
      | ofp_version        |              4 |
      | message_type       |              0 |
      | message_length     |             16 |
      | transaction_id     |            123 |
      | xid                |            123 |
      | supported_versions | [:open_flow13] |
