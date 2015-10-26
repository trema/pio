@open_flow10
Feature: Pio::OpenFlow10::SetVlanVid

  Scenario: new(1)
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetVlanVid.new(1)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value |
      | action_type   |     1 |
      | action_length |     8 |
      | vlan_id       |     1 |


