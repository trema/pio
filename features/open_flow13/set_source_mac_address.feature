@open_flow13
Feature: SetSourceMacAddress

  Scenario: new('11:22:33:44:55:66')
    When I create an OpenFlow action with:
      """
      Pio::SetSourceMacAddress.new('11:22:33:44:55:66')
      """
    Then the action has the following fields and values:
      | field         |             value |
      | action_type   |                25 |
      | action_length |                16 |
      | mac_address   | 11:22:33:44:55:66 |
