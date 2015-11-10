@open_flow13
Feature: Pio::SetArpOperation

  Scenario: new(Pio::Arp::Reply::OPERATION)
    When I try to create an OpenFlow action with:
      """
      Pio::SetArpOperation.new(Pio::Arp::Reply::OPERATION)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value |
      | action_type   |    25 |
      | action_length |    16 |
      | operation     |     2 |
