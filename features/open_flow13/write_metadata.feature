@open_flow13
Feature: Pio::WriteMetadata
  Scenario: new(metadata: 1)
    When I try to create an OpenFlow instruction with:
      """
      Pio::WriteMetadata.new(metadata: 1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |              value |
      | class              | Pio::WriteMetadata |
      | instruction_type   |                  2 |
      | instruction_length |                 24 |
      | to_binary_s.length |                 24 |
      | metadata           |                  1 |
      | metadata_mask      |                  0 |

  Scenario: read
    When I try to parse a file named "open_flow13/instruction_write_metadata.raw" with "Pio::WriteMetadata" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |              value |
      | class              | Pio::WriteMetadata |
      | instruction_type   |                  2 |
      | instruction_length |                 24 |
      | to_binary_s.length |                 24 |
      | metadata           |                  1 |
      | metadata_mask      |                  1 |
