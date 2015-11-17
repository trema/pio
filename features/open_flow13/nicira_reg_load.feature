@open_flow13
Feature: Pio::NiciraRegLoad

  Scenario: new(0xdeadbeef, :reg0)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraRegLoad.new(0xdeadbeef, :reg0)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field        |      value |
      | offset       |          0 |
      | n_bits       |         32 |
      | destination  |      :reg0 |
      | value.to_hex | 0xdeadbeef |

  Scenario: new(0xdeadbeef, :metadata)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraRegLoad.new(0xdeadbeef, :metadata)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field        |      value |
      | offset       |          0 |
      | n_bits       |         64 |
      | destination  |  :metadata |
      | value.to_hex | 0xdeadbeef |

  Scenario: new(0xdeadbeef, :reg0, offset: 16, n_bits: 16)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraRegLoad.new(0xdeadbeef, :reg0, offset: 16, n_bits: 16)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field        |      value |
      | offset       |         16 |
      | n_bits       |         16 |
      | destination  |      :reg0 |
      | value.to_hex | 0xdeadbeef |
