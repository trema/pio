@open_flow10
Feature: Pio::OpenFlow10::Enqueue

  Scenario: new(port: 1, queue_id: 2)
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow10::Enqueue.new(port: 1, queue_id: 2)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value |
      | action_type   |    11 |
      | action_length |    16 |
      | port          |     1 |
      | queue_id      |     2 |


