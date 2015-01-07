Feature: Pio::FlowMod.read
  Scenario: flow_mod_add.raw
    Given a packet data file "flow_mod_add.raw"
    When I try to parse the file with "FlowMod" class
    Then it should finish successfully
