@open_flow10
Feature: Pio::OpenFlow10::SetTos

  Scenario: new(0b11111100)
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetTos.new(0b11111100)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field           | value |
      | action_type     |     8 |
      | action_length   |     8 |
      | type_of_service |   252 |


