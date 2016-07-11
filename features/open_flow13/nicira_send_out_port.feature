@open_flow13
Feature: NiciraSendOutPort

  Outputs to the OpenFlow port number written to source[offset:offset+n_bits]

  Scenario: new(:reg0)
    When I create an OpenFlow action with:
      """
      Pio::NiciraSendOutPort.new(:reg0)
      """
    Then the action has the following fields and values:
      | field             |  value |
      | offset            |      0 |
      | n_bits            |     32 |
      | source            |  :reg0 |
      | max_length.to_hex | 0xffff |

  Scenario: new(:reg0, offset: 16, n_bits: 16, max_length: 256)
    When I create an OpenFlow action with:
      """
      Pio::NiciraSendOutPort.new(:reg0, offset: 16, n_bits: 16, max_length: 256)
      """
    Then the action has the following fields and values:
      | field      | value |
      | offset     |    16 |
      | n_bits     |    16 |
      | source     | :reg0 |
      | max_length |   256 |
