@open_flow13
Feature: DecrementIpTtl

  Scenario: new
    When I create an OpenFlow action with:
      """
      Pio::DecrementIpTtl.new
      """
    Then the action has the following fields and values:
      | field       | value |
      | action_type |    24 |
