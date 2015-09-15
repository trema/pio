@open_flow10
Feature: Pio::Enqueue

  Scenario: new(port: 1, queue_id: 2)
    When I try to create an OpenFlow action with:
      """
      Pio::Enqueue.new(port: 1, queue_id: 2)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field       | value |
      | action_type |    11 |
      | length      |    16 |
      | port        |     1 |
      | queue_id    |     2 |


