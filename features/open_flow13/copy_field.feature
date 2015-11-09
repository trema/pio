@open_flow13
Feature: Pio::CopyField

  Scenario: new(from: :arp_sender_hardware_address, to: :arp_target_hardware_address)
    When I try to create an OpenFlow action with:
      """
      Pio::CopyField.new(from: :arp_sender_hardware_address, to: :arp_target_hardware_address)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field                  |                        value |
      | action_type.to_hex     |                       0xffff |
      | action_length          |                           32 |
      | experimenter_id.to_hex |                   0x4f4e4600 |
      | experimenter_type      |                         3200 |
      | from                   | :arp_sender_hardware_address |
      | oxm_ids[0].oxm_field   |                           24 |
      | oxm_ids[0].oxm_length  |                            6 |
      | to                     | :arp_target_hardware_address |
      | oxm_ids[1].oxm_field   |                           25 |
      | oxm_ids[1].oxm_length  |                            6 |
