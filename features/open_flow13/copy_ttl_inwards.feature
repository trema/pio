@open_flow13
Feature: Pio::OpenFlow::CopyTtlInwards

  Copies TTL "inwards" -- from outermost to next-to-outermost

  Scenario: new
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow::CopyTtlInwards.new
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field       | value |
      | action_type |    12 |
