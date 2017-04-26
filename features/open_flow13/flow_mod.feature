@open_flow13
Feature: FlowMod
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::FlowMod.new
      """
    Then the message has the following fields and values:
      | field              |      value |
      | version            |          4 |
      | to_binary.length   |         56 |
      | transaction_id     |          0 |
      | xid                |          0 |
      | cookie             |          0 |
      | cookie_mask        |          0 |
      | table_id           |          0 |
      | command            |       :add |
      | idle_timeout       |          0 |
      | hard_timeout       |          0 |
      | priority.to_hex    |     0xffff |
      | buffer_id          | :no_buffer |
      | out_port           |       :any |
      | out_group          |       :any |
      | flags              |         [] |
      | match.match_fields |         [] |
      | instructions       |         [] |

  Scenario: new(instructions: Pio::Apply.new(Pio::SendOutPort.new(1)))
    When I create an OpenFlow message with:
      """
      Pio::FlowMod.new(instructions: Pio::Apply.new(Pio::SendOutPort.new(1)))
      """
    Then the message has the following fields and values:
      | field                                  |                        value |
      | version                                |                            4 |
      | transaction_id                         |                            0 |
      | xid                                    |                            0 |
      | cookie                                 |                            0 |
      | cookie_mask                            |                            0 |
      | table_id                               |                            0 |
      | command                                |                         :add |
      | idle_timeout                           |                            0 |
      | hard_timeout                           |                            0 |
      | priority.to_hex                        |                       0xffff |
      | buffer_id                              |                   :no_buffer |
      | out_port                               |                         :any |
      | out_group                              |                         :any |
      | flags                                  |                           [] |
      | match.match_fields                     |                           [] |
      | instructions.size                      |                            1 |
      | instructions.at(0).class               |       Pio::OpenFlow13::Apply |
      | instructions.at(0).actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | instructions.at(0).actions.at(0).port  |                            1 |

  Scenario: new(match: Pio::Match.new(in_port: 1), instructions: Pio::Apply.new(Pio::SendOutPort.new(1)))
    When I create an OpenFlow message with:
      """
      Pio::FlowMod.new(match: Pio::Match.new(in_port: 1), instructions: Pio::Apply.new(Pio::SendOutPort.new(1)))
      """
    Then the message has the following fields and values:
      | field                                  |                        value |
      | version                                |                            4 |
      | transaction_id                         |                            0 |
      | xid                                    |                            0 |
      | cookie                                 |                            0 |
      | cookie_mask                            |                            0 |
      | table_id                               |                            0 |
      | command                                |                         :add |
      | idle_timeout                           |                            0 |
      | hard_timeout                           |                            0 |
      | priority.to_hex                        |                       0xffff |
      | buffer_id                              |                   :no_buffer |
      | out_port                               |                         :any |
      | out_group                              |                         :any |
      | flags                                  |                           [] |
      | match.in_port                          |                            1 |
      | instructions.size                      |                            1 |
      | instructions.at(0).class               |       Pio::OpenFlow13::Apply |
      | instructions.at(0).actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | instructions.at(0).actions.at(0).port  |                            1 |
