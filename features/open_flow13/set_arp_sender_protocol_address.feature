@open_flow13
Feature: Pio::SetArpSenderProtocolAddress

  Scenario: new('192.168.1.1')
    When I try to create an OpenFlow action with:
      """
      Pio::SetArpSenderProtocolAddress.new('192.168.1.1')
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |       value |
      | action_type   |          25 |
      | action_length |          16 |
      | ip_address    | 192.168.1.1 |
