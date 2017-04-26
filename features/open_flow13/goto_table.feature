@open_flow13
Feature: GotoTable
  Scenario: new(1)
    When I create an OpenFlow instruction with:
      """
      Pio::OpenFlow13::GotoTable.new(1)
      """
    Then the message has the following fields and values:
      | field              |                      value |
      | class              | Pio::OpenFlow13::GotoTable |
      | instruction_type   |                          1 |
      | instruction_length |                          8 |
      | to_binary_s.length |                          8 |
      | table_id           |                          1 |

  Scenario: read
    When I parse a file named "open_flow13/instruction_goto_table.raw" with "Pio::OpenFlow13::GotoTable" class
    Then the message has the following fields and values:
      | field              |                      value |
      | class              | Pio::OpenFlow13::GotoTable |
      | instruction_type   |                          1 |
      | instruction_length |                          8 |
      | to_binary_s.length |                          8 |
      | table_id           |                          1 |
