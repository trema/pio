@open_flow10
Feature: Pio::SetTransportSourcePort

  Scenario: new(100)
    When I try to create an OpenFlow action with:
      """
      Pio::SetTransportSourcePort.new(100)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field          | value |
      | action_type    |     9 |
      | message_length |     8 |
      | port_number    |   100 |


