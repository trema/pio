Feature: Pio::FlowMod.read
  Scenario: flow_mod_add.raw
    Given a packet data file "flow_mod_add.raw"
    When I try to parse the file with "FlowMod" class
    Then it should finish successfully
    And the "ofp_version" of the packet data is "1"
    And the "message_type" of the packet data is "14"
    And the "message_length" of the packet data is "80"
    And the "transaction_id" of the packet data is "21"
    And the "xid" of the packet data is "21"
    And the "cookie" of the packet data is "1"
    And the "command" of the packet data is "add"
    And the "idle_timeout" of the packet data is "0"
    And the "hard_timeout" of the packet data is "0"
    And the "priority" of the packet data is "65535"
    And the "buffer_id" of the packet data is "4294967295"
    And the "out_port" of the packet data is "2"
    And the "flags" of the packet data is "[:send_flow_rem, :check_overwrap]"
    And the "actions.length" of the packet data is "1"
    And the "actions.first.class" of the packet data is "Pio::SendOutPort"
    And the "actions.first.port_number" of the packet data is "2"
    And the "actions.first.max_len" of the packet data is "65535"

