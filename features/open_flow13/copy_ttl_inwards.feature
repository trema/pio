@open_flow13
Feature: CopyTtlInwards

  Copies TTL "inwards" -- from outermost to next-to-outermost

  Scenario: new
    When I create an OpenFlow action with:
      """
      Pio::CopyTtlInwards.new
      """
    Then the action has the following fields and values:
      | field       | value |
      | action_type |    12 |
