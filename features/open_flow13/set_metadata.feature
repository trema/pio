@open_flow13
Feature: SetMetadata

  Scenario: new(0x123)
    When I create an OpenFlow action with:
      """
      Pio::SetMetadata.new(0x123)
      """
    Then the action has the following fields and values:
      | field           | value |
      | action_type     |    25 |
      | action_length   |    16 |
      | metadata.to_hex | 0x123 |
