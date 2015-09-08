@open_flow10
Feature: Pio::SetTransportDestinationPort

  Scenario: new(100)
    When I try to create an OpenFlow action with:
      """
      Pio::SetTransportDestinationPort.new(100)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field       | value |
      | action_type |    10 |
      | length      |     8 |
      | port        |   100 |


