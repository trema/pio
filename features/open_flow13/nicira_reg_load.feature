@open_flow13
Feature: Pio::NiciraRegLoad

  Scenario: new(0xdeadbeef, :reg0)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraRegLoad.new(0xdeadbeef, :reg0)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field                  |      value |
      | action_type.to_hex     |     0xffff |
      | action_length          |         24 |
      | experimenter_id.to_hex |     0x2320 |
      | experimenter_type      |          7 |
      | offset                 |          0 |
      | n_bits                 |         32 |
      | destination            |      :reg0 |
      | destination_internal   |      65540 |
      | value.to_hex           | 0xdeadbeef |

  Scenario: new(0xdeadbeef, :metadata)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraRegLoad.new(0xdeadbeef, :metadata)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field                  |      value |
      | action_type.to_hex     |     0xffff |
      | action_length          |         24 |
      | experimenter_id.to_hex |     0x2320 |
      | experimenter_type      |          7 |
      | offset                 |          0 |
      | n_bits                 |         64 |
      | destination            |  :metadata |
      | destination_internal   | 2147484680 |
      | value.to_hex           | 0xdeadbeef |

  Scenario: new(0xdeadbeef, :metadata, offset: 32, n_bits: 32)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraRegLoad.new(0xdeadbeef, :metadata, offset: 32, n_bits: 32)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field                  |      value |
      | action_type.to_hex     |     0xffff |
      | action_length          |         24 |
      | experimenter_id.to_hex |     0x2320 |
      | experimenter_type      |          7 |
      | offset                 |         32 |
      | n_bits                 |         32 |
      | destination            |  :metadata |
      | destination_internal   | 2147484680 |
      | value.to_hex           | 0xdeadbeef |
