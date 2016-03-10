@open_flow10
Feature: QueueStats::Request

  Information about queues is requested with a Queue Stats Request
  message.

  Scenario: new(port: 1, queue_id: 1)
    When I create an OpenFlow message with:
      """
      Pio::OpenFlow10::QueueStats::Request.new(port: 1, queue_id: 1)
      """
    Then the message has the following fields and values:
      | field          |  value |
      | version        |      1 |
      | transaction_id |      0 |
      | xid            |      0 |
      | stats_type     | :queue |
      | port           |      1 |
      | queue_id       |      1 |

  Scenario: new(port: 1, queue_id: 1, transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::OpenFlow10::QueueStats::Request.new(port: 1, queue_id: 1, transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          |  value |
      | version        |      1 |
      | transaction_id |    123 |
      | xid            |    123 |
      | stats_type     | :queue |
      | port           |      1 |
      | queue_id       |      1 |
