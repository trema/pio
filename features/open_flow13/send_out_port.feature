@open_flow13
Feature: Pio::SendOutPort
  Scenario: new(1)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(1)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field         |            value |
      | action_type   |                0 |
      | action_length |               16 |
      | port          |                1 |
      | max_length    |       :no_buffer |

  Scenario: read
    When I try to parse a file named "open_flow13/send_out_port.raw" with "Pio::SendOutPort" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field         |            value |
      | action_type   |                0 |
      | action_length |               16 |
      | port          |                1 |
      | max_length    |       :no_buffer |
