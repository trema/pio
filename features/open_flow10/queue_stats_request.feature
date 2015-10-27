Feature: Pio::OpenFlow10::QueueStats::Request
  @open_flow10
  Scenario: new(port: 1, queue_id: 1)
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow10::QueueStats::Request.new(port: 1, queue_id: 1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |  value |
      | ofp_version    |      1 |
      | message_type   |     16 |
      | message_length |     20 |
      | transaction_id |      0 |
      | xid            |      0 |
      | stats_type     | :queue |
      | port           |      1 |
      | queue_id       |      1 |

  @open_flow10
  Scenario: new(port: 1, queue_id: 1, transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow10::QueueStats::Request.new(port: 1, queue_id: 1, transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |  value |
      | ofp_version    |      1 |
      | message_type   |     16 |
      | message_length |     20 |
      | transaction_id |    123 |
      | xid            |    123 |
      | stats_type     | :queue |
      | port           |      1 |
      | queue_id       |      1 |

  @open_flow10
  Scenario: read
    When I try to parse a file named "open_flow10/queue_stats_request.raw" with "QueueStats::Request" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |  value |
      | ofp_version    |      1 |
      | message_type   |     16 |
      | message_length |     20 |
      | transaction_id |    123 |
      | xid            |    123 |
      | stats_type     | :queue |
      | port           |   :all |
      | queue_id       |      1 |
