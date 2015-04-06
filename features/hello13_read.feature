Feature: Pio::Hello13.read
  Scenario: hello13_no_version_bitmap.raw
    Given a packet data file "hello13_no_version_bitmap.raw"
    When I try to parse the file with "Hello13" class
    Then it should finish successfully
    And the parsed data have the following field and value:
      | field              |        value |
      | class              | Pio::Hello13 |
      | ofp_version        |            4 |
      | message_type       |            0 |
      | message_length     |            8 |
      | transaction_id     |            0 |
      | xid                |            0 |
      | supported_versions |           [] |

  Scenario: hello13_version_bitmap.raw
    Given a packet data file "hello13_version_bitmap.raw"
    When I try to parse the file with "Hello13" class
    Then it should finish successfully
    And the parsed data have the following field and value:
      | field              |                        value |
      | class              |                 Pio::Hello13 |
      | ofp_version        |                            4 |
      | message_type       |                            0 |
      | message_length     |                           16 |
      | transaction_id     |                            0 |
      | xid                |                            0 |
      | supported_versions | [:open_flow10, :open_flow13] |
