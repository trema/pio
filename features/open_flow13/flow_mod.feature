@open_flow13
Feature: Pio::FlowMod
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::FlowMod.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |      value |
      | ofp_version        |          4 |
      | message_type       |         14 |
      | message_length     |         56 |
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

  Scenario: new(instructions: Pio::Apply.new(SendOutPort.new(1)))
    When I try to create an OpenFlow message with:
      """
      Pio::FlowMod.new(instructions: Pio::Apply.new(SendOutPort.new(1)))
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                                  |                        value |
      | ofp_version                            |                            4 |
      | message_type                           |                           14 |
      | message_length                         |                           80 |
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
      | instructions.at(0).class               |                   Pio::Apply |
      | instructions.at(0).actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | instructions.at(0).actions.at(0).port  |                            1 |

  Scenario: new(match: Pio::Match.new(in_port: 1), instructions: Pio::Apply.new(SendOutPort.new(1)))
    When I try to create an OpenFlow message with:
      """
      Pio::FlowMod.new(match: Pio::Match.new(in_port: 1), instructions: Pio::Apply.new(SendOutPort.new(1)))
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                                  |                        value |
      | ofp_version                            |                            4 |
      | message_type                           |                           14 |
      | message_length                         |                           88 |
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
      | instructions.at(0).class               |                   Pio::Apply |
      | instructions.at(0).actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | instructions.at(0).actions.at(0).port  |                            1 |

  Scenario: read (no match or instructions)
    When I try to parse a file named "open_flow13/flow_mod_no_match_or_instructions.raw" with "Pio::FlowMod" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |      value |
      | ofp_version        |          4 |
      | message_type       |         14 |
      | message_length     |         56 |
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

  Scenario: read (instruction = apply, action = SendOutPort(port: 1))
    When I try to parse a file named "open_flow13/flow_mod_add_apply_no_match.raw" with "Pio::FlowMod" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                                  |                        value |
      | ofp_version                            |                            4 |
      | message_type                           |                           14 |
      | message_length                         |                           80 |
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
      | instructions.at(0).class               |                   Pio::Apply |
      | instructions.at(0).actions.at(0).class | Pio::OpenFlow13::SendOutPort |
      | instructions.at(0).actions.at(0).port  |                            1 |
