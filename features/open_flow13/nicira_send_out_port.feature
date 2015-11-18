@open_flow13
Feature: Pio::NiciraSendOutPort

  Scenario: new(:reg0)
    When I try to create an OpenFlow action with:
      """
      Pio::NiciraSendOutPort.new(:reg0)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field      | value |
      | offset     |     0 |
      | n_bits     |    32 |
      | source     | :reg0 |
      | max_length |     0 |
