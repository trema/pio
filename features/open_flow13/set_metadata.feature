@open_flow13
Feature: Pio::SetMetadata

  Scenario: new(0x123)
    When I try to create an OpenFlow action with:
      """
      Pio::SetMetadata.new(0x123)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field           | value |
      | action_type     |    25 |
      | action_length   |    16 |
      | metadata.to_hex | 0x123 |
