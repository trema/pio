@open_flow10
Feature: SetVlanVid

  Scenario: new(1)
    When I create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetVlanVid.new(1)
      """
    Then the action has the following fields and values:
      | field         | value |
      | action_type   |     1 |
      | action_length |     8 |
      | vlan_id       |     1 |


