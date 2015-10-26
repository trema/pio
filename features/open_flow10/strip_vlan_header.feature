@open_flow10
Feature: Pio::OpenFlow10::StripVlanHeader

  Scenario: new
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow10::StripVlanHeader.new
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value |
      | action_type   |     3 |
      | action_length |     8 |


