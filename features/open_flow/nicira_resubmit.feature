@open_flow13
Feature: Pio::OpenFlow::NiciraResubmit

  Scenario: new(1)
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow::NiciraResubmit.new(1)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field              |  value |
      | in_port            |      1 |
