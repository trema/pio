@open_flow10
Feature: SetTransportSourcePort

  Scenario: new(100)
    When I create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetTransportSourcePort.new(100)
      """
    Then the action has the following fields and values:
      | field         | value |
      | action_type   |     9 |
      | action_length |     8 |
      | port          |   100 |


