@open_flow10
Feature: SetVlanPriority

  Scenario: new(1)
    When I create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetVlanPriority.new(1)
      """
    Then the action has the following fields and values:
      | field         | value |
      | action_type   |     2 |
      | action_length |     8 |
      | vlan_priority |     1 |


