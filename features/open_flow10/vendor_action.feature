@open_flow10
Feature: Pio::VendorAction

  Scenario: new(1)
    When I try to create an OpenFlow action with:
      """
      Pio::VendorAction.new(1)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field              |  value |
      | action_type.to_hex | 0xffff |
      | length             |      8 |
      | vendor             |      1 |
