@open_flow13
Feature: SetArpOperation

  Scenario: new(Pio::Arp::Reply::OPERATION)
    When I create an OpenFlow action with:
      """
      Pio::SetArpOperation.new(Pio::Arp::Reply::OPERATION)
      """
    Then the action has the following fields and values:
      | field         | value |
      | action_type   |    25 |
      | action_length |    16 |
      | operation     |     2 |
