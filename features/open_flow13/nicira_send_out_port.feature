@open_flow13
Feature: Pio::NiciraSendOutPort

  Scenario: new(:reg0)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraSendOutPort.new(:reg0)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field                  |  value |
      | action_type.to_hex     | 0xffff |
      | action_length          |     24 |
      | experimenter_id.to_hex | 0x2320 |
      | experimenter_type      |     15 |
      | offset                 |      0 |
      | source                 |  :reg0 |
      | max_length             |      0 |

    
