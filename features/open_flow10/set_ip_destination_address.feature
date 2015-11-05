@open_flow10
Feature: Pio::OpenFlow10::SetDestinationIpAddress

  Scenario: new('192.168.0.1')
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow10::SetDestinationIpAddress.new('192.168.0.1')
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |       value |
      | action_type   |           7 |
      | action_length |           8 |
      | ip_address    | 192.168.0.1 |


