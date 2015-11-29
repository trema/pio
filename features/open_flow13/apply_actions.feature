@open_flow13
Feature: Apply
  Scenario: new()
    When I create an OpenFlow instruction with:
      """
      Pio::Apply.new
      """
    Then the message has the following fields and values:
      | field              | value                  |
      | class              | Pio::OpenFlow13::Apply |
      | instruction_type   | 4                      |
      | instruction_length | 8                      |
      | actions            | []                     |

  Scenario: new(SendOutPort.new(1))
    When I create an OpenFlow instruction with:
      """
      Pio::Apply.new(Pio::SendOutPort.new(1))
      """
    Then the message has the following fields and values:
      | field               |                        value |
      | class               |       Pio::OpenFlow13::Apply |
      | instruction_type    |                            4 |
      | instruction_length  |                           24 |
      | actions.size        |                            1 |
      | actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | actions.at(0).port  |                            1 |

  Scenario: read
    When I parse a file named "open_flow13/apply_actions.raw" with "Pio::Apply" class
    Then the message has the following fields and values:
      | field               |                        value |
      | class               |       Pio::OpenFlow13::Apply |
      | instruction_type    |                            4 |
      | instruction_length  |                           24 |
      | actions.size        |                            1 |
      | actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | actions.at(0).port  |                            1 |
