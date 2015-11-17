@open_flow13
Feature: Pio::SetArpSenderHardwareAddress

  Scenario: new('00:00:de:ad:be:ef')
    When I try to create an OpenFlow action with:
      """
      Pio::SetArpSenderHardwareAddress.new('00:00:de:ad:be:ef')
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |             value |
      | action_type   |                25 |
      | action_length |                16 |
      | mac_address   | 00:00:de:ad:be:ef |
