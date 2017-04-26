@open_flow10
Feature: SetTos

  Scenario: new(0b11111100)
    When I create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetTos.new(0b11111100)
      """
    Then the action has the following fields and values:
      | field           | value |
      | action_type     |     8 |
      | action_length   |     8 |
      | type_of_service |   252 |


