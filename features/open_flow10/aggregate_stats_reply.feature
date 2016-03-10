@open_flow10
Feature: AggregateStats::Reply

  Scenario: read
    When I parse a file named "open_flow10/aggregate_stats_reply.raw" with "AggregateStats::Reply" class
    Then the message has the following fields and values:
      | field          |      value |
      | version        |          1 |
      | transaction_id |         15 |
      | xid            |         15 |
      | stats_type     | :aggregate |
      | flags          |          0 |
      | packet_count   |          0 |
      | byte_count     |          0 |
      | flow_count     |          0 |
