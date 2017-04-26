@open_flow13
Feature: Hello
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Hello.new
      """
    Then the message has the following fields and values:
      | field              |          value |
      | version            |              4 |
      | transaction_id     |              0 |
      | xid                |              0 |
      | supported_versions | [:open_flow13] |

  Scenario: new(transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::Hello.new(transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field              |          value |
      | version            |              4 |
      | transaction_id     |            123 |
      | xid                |            123 |
      | supported_versions | [:open_flow13] |
