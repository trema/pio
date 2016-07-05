@open_flow10
Feature: VendorAction

  Scenario: new(1)
    When I create an OpenFlow action with:
      """
      Pio::OpenFlow10::VendorAction.new(1)
      """
    Then the action has the following fields and values:
      | field              |      value |
      | action_type.to_hex | 0xff, 0xff |
      | length             |          8 |
      | vendor             |          1 |
