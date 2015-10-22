@open_flow10
Feature: Pio::AggregateStats::Reply
  Scenario: read
    When I try to parse a file named "open_flow10/aggregate_stats_reply.raw" with "AggregateStats::Reply" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |      value |
      | ofp_version    |          1 |
      | message_type   |         17 |
      | message_length |         36 |
      | transaction_id |         15 |
      | xid            |         15 |
      | stats_type     | :aggregate |
      | flags          |          0 |
      | packet_count   |          0 |
      | byte_count     |          0 |
      | flow_count     |          0 |
