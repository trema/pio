@open_flow10
Feature: StripVlanHeader

  Scenario: new
    When I create an OpenFlow action with:
      """
      Pio::OpenFlow10::StripVlanHeader.new
      """
    Then the action has the following fields and values:
      | field         | value |
      | action_type   |     3 |
      | action_length |     8 |


