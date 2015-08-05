@open_flow13
Feature: Apply-Actions instruction.
  Scenario: new()
    When I try to create an OpenFlow instruction with:
      """
      Pio::Apply.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              | value      |
      | class              | Pio::Apply |
      | instruction_type   | 4          |
      | instruction_length | 8          |
      | actions            | []         |

  Scenario: new(SendOutPort.new(1))
    When I try to create an OpenFlow instruction with:
      """
      Pio::Apply.new(SendOutPort.new(1))
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field               |                        value |
      | class               |                   Pio::Apply |
      | instruction_type    |                            4 |
      | instruction_length  |                           24 |
      | actions.size        |                            1 |
      | actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | actions.at(0).port  |                            1 |

  Scenario: read
    When I try to parse a file named "open_flow13/apply_actions.raw" with "Pio::Apply" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field               |                        value |
      | class               |                   Pio::Apply |
      | instruction_type    |                            4 |
      | instruction_length  |                           24 |
      | actions.size        |                            1 |
      | actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | actions.at(0).port  |                            1 |
