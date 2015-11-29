@open_flow13
Feature: CopyTtlOutwards

  Copies TTL "outwards" -- from next-to-outermost to outermost

  Scenario: new
    When I create an OpenFlow action with:
      """
      Pio::CopyTtlOutwards.new
      """
    Then the action has the following fields and values:
      | field       | value |
      | action_type |    11 |
