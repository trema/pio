@open_flow10
Feature: DescriptionStats::Reply

  Information about the switch manufacturer, hardware revision,
  software revision, serial number, and a description field is
  available from a Description Stats Reply.

  Scenario: read
    When I parse a file named "open_flow10/description_stats_reply.raw" with "DescriptionStats::Reply" class
    Then the message has the following fields and values:
      | field          |        value |
      | version        |            1 |
      | transaction_id |           12 |
      | xid            |           12 |
      | stats_type     | :description |
      | manufacturer   | Nicira, Inc. |
      | hardware       |              |
      | software       |              |
      | serial_number  |              |
      | datapath       |              |
