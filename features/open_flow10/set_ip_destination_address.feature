@open_flow10
Feature: SetDestinationIpAddress

  Scenario: new('192.168.0.1')
    When I create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetDestinationIpAddress.new('192.168.0.1')
      """
    Then the action has the following fields and values:
      | field         |       value |
      | action_type   |           7 |
      | action_length |           8 |
      | ip_address    | 192.168.0.1 |


