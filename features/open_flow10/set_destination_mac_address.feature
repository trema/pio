@open_flow10
Feature: SetDestinationMacAddress

  Scenario: new('11:22:33:44:55:66')
    When I create an OpenFlow action with:
      """
      Pio::SetDestinationMacAddress.new('11:22:33:44:55:66')
      """
    Then the action has the following fields and values:
      | field         |             value |
      | action_type   |                 5 |
      | action_length |                16 |
      | mac_address   | 11:22:33:44:55:66 |


