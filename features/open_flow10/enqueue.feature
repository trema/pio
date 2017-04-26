@open_flow10
Feature: Enqueue

  Scenario: new(port: 1, queue_id: 2)
    When I create an OpenFlow action with:
      """
      Pio::OpenFlow10::Enqueue.new(port: 1, queue_id: 2)
      """
    Then the action has the following fields and values:
      | field         | value |
      | action_type   |    11 |
      | action_length |    16 |
      | port          |     1 |
      | queue_id      |     2 |


