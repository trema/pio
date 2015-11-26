@open_flow13
Feature: DecrementIpTtl

  Scenario: new
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow::DecrementIpTtl.new
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field       | value |
      | action_type |    24 |
