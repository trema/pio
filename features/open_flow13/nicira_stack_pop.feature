@open_flow13
Feature: NiciraStackPop

  Pops field[offset: offset + n_bits] from top of the stack.

  Scenario: new(:reg0)
    When I create an OpenFlow action with:
      """
      Pio::NiciraStackPop.new(:reg0)
      """
    Then the action has the following fields and values:
      | field  | value |
      | offset |     0 |
      | n_bits |    32 |
      | field  | :reg0 |

  Scenario: new(:reg0, n_bits: 16, offset: 16)
    When I create an OpenFlow action with:
      """
      Pio::NiciraStackPop.new(:reg0, n_bits: 16, offset: 16)
      """
    Then the action has the following fields and values:
      | field  | value |
      | offset |    16 |
      | n_bits |    16 |
      | field  | :reg0 |
