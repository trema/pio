Feature: Pio::FlowMod.read
  Scenario: flow_mod_add.raw
    Given a packet data file "flow_mod_add.raw"
    When I try to parse the file with "FlowMod" class
    Then it should finish successfully
    And the parsed data have the following field and value:
    | field                     |                                                                                                                value |
    | ofp_version               |                                                                                                                    1 |
    | message_type              |                                                                                                                   14 |
    | message_length            |                                                                                                                   80 |
    | transaction_id            |                                                                                                                   21 |
    | xid                       |                                                                                                                   21 |
    | match.wildcards           | [:dl_vlan, :dl_src, :dl_dst, :dl_type, :nw_proto, :tp_src, :tp_dst, :nw_src_all, :nw_dst_all, :dl_vlan_pcp, :nw_tos] |
    | cookie                    |                                                                                                                    1 |
    | command                   |                                                                                                                  add |
    | idle_timeout              |                                                                                                                    0 |
    | hard_timeout              |                                                                                                                    0 |
    | priority                  |                                                                                                                65535 |
    | buffer_id                 |                                                                                                           4294967295 |
    | out_port                  |                                                                                                                    2 |
    | flags                     |                                                                                    [:send_flow_rem, :check_overwrap] |
    | actions.length            |                                                                                                                    1 |
    | actions.first.class       |                                                                                                     Pio::SendOutPort |
    | actions.first.port_number |                                                                                                                    2 |
    | actions.first.max_len     |                                                                                                                65535 |
    
