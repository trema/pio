@open_flow13
Feature: NiciraResubmit

  Scenario: new(1)
    When I create an OpenFlow action with:
      """
      Pio::NiciraResubmit.new(1)
      """
    Then the action has the following fields and values:
      | field              |  value |
      | in_port            |      1 |
