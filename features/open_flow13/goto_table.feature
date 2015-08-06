@open_flow13
Feature: Pio::GotoTable
  Scenario: new(1)
    When I try to create an OpenFlow instruction with:
      """
      Pio::GotoTable.new(1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |          value |
      | class              | Pio::GotoTable |
      | instruction_type   |              1 |
      | instruction_length |              8 |
      | to_binary_s.length |              8 |
      | table_id           |              1 |

  Scenario: read
    When I try to parse a file named "open_flow13/instruction_goto_table.raw" with "Pio::GotoTable" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |          value |
      | class              | Pio::GotoTable |
      | instruction_type   |              1 |
      | instruction_length |              8 | 
      | to_binary_s.length |              8 |
      | table_id           |              1 |
