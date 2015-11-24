@open_flow13
Feature: Pio::CopyTtlInwards

  Copies TTL "inwards" -- from outermost to next-to-outermost

  Scenario: new
    When I try to create an OpenFlow action with:
      """
      Pio::CopyTtlInwards.new
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field       | value |
      | action_type |    12 |
