@open_flow13
Feature: SetIpTtl

  Scenario: new(10)
    When I create an OpenFlow action with:
      """
      Pio::SetIpTtl.new(10)
      """
    Then the action has the following fields and values:
      | field       | value |
      | action_type |    23 |
      | ttl         |    10 |
