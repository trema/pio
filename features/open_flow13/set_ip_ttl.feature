@open_flow13
Feature: SetIpTtl

  Scenario: new(10)
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow::SetIpTtl.new(10)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field       | value |
      | action_type |    23 |
      | ttl         |    10 |
