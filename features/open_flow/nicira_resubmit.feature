Feature: Pio::NiciraResubmit

  Scenario: new(1)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraResubmit.new(1)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field              |  value |
      | action_type.to_hex | 0xffff |
      | action_length      |     16 |
      | vendor.to_hex      | 0x2320 |
      | subtype            |      1 |
      | in_port            |      1 |

  Scenario: new(:in_port)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraResubmit.new(:in_port)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field              |    value |
      | action_type.to_hex |   0xffff |
      | action_length      |       16 |
      | vendor.to_hex      |   0x2320 |
      | subtype            |        1 |
      | in_port            | :in_port |
