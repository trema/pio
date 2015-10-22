@open_flow10
Feature: Pio::DescriptionStats::Reply
  Scenario: read
    When I try to parse a file named "open_flow10/description_stats_reply.raw" with "DescriptionStats::Reply" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |        value |
      | ofp_version    |            1 |
      | message_type   |           17 |
      | message_length |         1068 |
      | transaction_id |           12 |
      | xid            |           12 |
      | stats_type     | :description |
      | manufacturer   | Nicira, Inc. |
      | hardware       |              |
      | software       |              |
      | serial_number  |              |
      | datapath       |              |
