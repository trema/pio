Feature: Pio::FlowMod.read
  Scenario: flow_mod_add.raw
    Given a packet data file "flow_mod_add.raw"
    When I try to parse the file with "FlowMod" class
    Then it should finish successfully
    And the parsed data have the following field and value:
    | field                 |              value |
    | ofp_version           |                  1 |
    | message_type          |                 14 |
    | message_length        |                192 |
    | transaction_id        |                  0 |
    | xid                   |                  0 |
    | match.wildcards.keys  | [:nw_src, :nw_dst] |
    | cookie                |                  0 |
    | command               |                add |
    | idle_timeout          |                  0 |
    | hard_timeout          |                  0 |
    | priority              |              65535 |
    | buffer_id             |         4294967295 |
    | out_port              |              65535 |
    | flags                 |   [:send_flow_rem] |
    | actions.length        |                 12 |
    | actions.first.class   |    Pio::SetVlanVid |
    | actions.first.vlan_id |                 10 |
    
