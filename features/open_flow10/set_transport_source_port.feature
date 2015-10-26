@open_flow10
Feature: Pio::OpenFlow10::SetTransportSourcePort

  Scenario: new(100)
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetTransportSourcePort.new(100)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value |
      | action_type   |     9 |
      | action_length |     8 |
      | port          |   100 |


