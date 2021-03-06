@open_flow13
Feature: WriteMetadata
  Scenario: new(metadata: 1)
    When I create an OpenFlow instruction with:
      """
      Pio::OpenFlow13::WriteMetadata.new(metadata: 1)
      """
    Then the message has the following fields and values:
      | field              |                          value |
      | class              | Pio::OpenFlow13::WriteMetadata |
      | instruction_type   |                              2 |
      | instruction_length |                             24 |
      | to_binary_s.length |                             24 |
      | metadata           |                              1 |
      | metadata_mask      |                              0 |

  Scenario: read
    When I parse a file named "open_flow13/instruction_write_metadata.raw" with "Pio::OpenFlow13::WriteMetadata" class
    Then the message has the following fields and values:
      | field              |                          value |
      | class              | Pio::OpenFlow13::WriteMetadata |
      | instruction_type   |                              2 |
      | instruction_length |                             24 |
      | to_binary_s.length |                             24 |
      | metadata           |                              1 |
      | metadata_mask      |                              1 |
