Feature: Flow Mod
  Scenario: parse (Flow Mod Add)
    When I try to parse a file named "flow_mod_add.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                  |                      value |
      | ofp_version            |                          1 |
      | message_type           |                         14 |
      | message_length         |                        192 |
      | transaction_id         |                          0 |
      | xid                    |                          0 |
      | match.wildcards        | {:nw_src=>24, :nw_dst=>24} |
      | match.in_port          |                          1 |
      | match.eth_src_addr     |          00:00:00:00:00:0a |
      | match.eth_dst_addr     |          00:00:00:00:00:14 |
      | match.dl_vlan          |                          0 |
      | match.dl_vlan_pcp      |                          0 |
      | match.eth_type         |                       2048 |
      | match.nw_tos           |                          0 |
      | match.nw_proto         |                          1 |
      | match.nw_src           |                   10.0.0.0 |
      | match.nw_src.prefixlen |                          8 |
      | match.nw_dst           |                   20.0.0.0 |
      | match.nw_dst.prefixlen |                          8 |
      | match.tp_src           |                          8 |
      | match.tp_dst           |                          0 |
      | cookie                 |                          0 |
      | command                |                        add |
      | idle_timeout           |                          0 |
      | hard_timeout           |                          0 |
      | priority               |                      65535 |
      | buffer_id              |                 4294967295 |
      | out_port               |                      65535 |
      | flags                  |           [:send_flow_rem] |
      | actions.length         |                         12 |
      | actions.first.class    |            Pio::SetVlanVid |
      | actions.first.vlan_id  |                         10 |

  Scenario: parse (Flow Mod Modify)
    When I try to parse a file named "flow_mod_modify.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                  |                      value |
      | ofp_version            |                          1 |
      | message_type           |                         14 |
      | message_length         |                        192 |
      | transaction_id         |                          0 |
      | xid                    |                          0 |
      | match.wildcards        | {:nw_src=>24, :nw_dst=>24} |
      | match.in_port          |                          1 |
      | match.eth_src_addr     |          00:00:00:00:00:0a |
      | match.eth_dst_addr     |          00:00:00:00:00:14 |
      | match.dl_vlan          |                          0 |
      | match.dl_vlan_pcp      |                          0 |
      | match.eth_type         |                       2048 |
      | match.nw_tos           |                          0 |
      | match.nw_proto         |                          1 |
      | match.nw_src           |                   10.0.0.0 |
      | match.nw_src.prefixlen |                          8 |
      | match.nw_dst           |                   20.0.0.0 |
      | match.nw_dst.prefixlen |                          8 |
      | match.tp_src           |                          8 |
      | match.tp_dst           |                          0 |
      | cookie                 |                          0 |
      | command                |                     modify |
      | idle_timeout           |                          0 |
      | hard_timeout           |                          0 |
      | priority               |                      65535 |
      | buffer_id              |                 4294967295 |
      | out_port               |                      65535 |
      | flags                  |           [:send_flow_rem] |
      | actions.length         |                         12 |
      | actions.first.class    |            Pio::SetVlanVid |
      | actions.first.vlan_id  |                         10 |

Scenario: parse (Flow Mod Modify Strict)
    When I try to parse a file named "flow_mod_modify_strict.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                  |                      value |
      | ofp_version            |                          1 |
      | message_type           |                         14 |
      | message_length         |                        192 |
      | transaction_id         |                          0 |
      | xid                    |                          0 |
      | match.wildcards        | {:nw_src=>24, :nw_dst=>24} |
      | match.in_port          |                          1 |
      | match.eth_src_addr     |          00:00:00:00:00:0a |
      | match.eth_dst_addr     |          00:00:00:00:00:14 |
      | match.dl_vlan          |                          0 |
      | match.dl_vlan_pcp      |                          0 |
      | match.eth_type         |                       2048 |
      | match.nw_tos           |                          0 |
      | match.nw_proto         |                          1 |
      | match.nw_src           |                   10.0.0.0 |
      | match.nw_src.prefixlen |                          8 |
      | match.nw_dst           |                   20.0.0.0 |
      | match.nw_dst.prefixlen |                          8 |
      | match.tp_src           |                          8 |
      | match.tp_dst           |                          0 |
      | cookie                 |                          0 |
      | command                |              modify_strict |
      | idle_timeout           |                          0 |
      | hard_timeout           |                          0 |
      | priority               |                      65535 |
      | buffer_id              |                 4294967295 |
      | out_port               |                      65535 |
      | flags                  |           [:send_flow_rem] |
      | actions.length         |                         12 |
      | actions.first.class    |            Pio::SetVlanVid |
      | actions.first.vlan_id  |                         10 |
    
  Scenario: parse (Flow Mod Delete)
    When I try to parse a file named "flow_mod_delete.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                  |                      value |
      | ofp_version            |                          1 |
      | message_type           |                         14 |
      | message_length         |                         72 |
      | transaction_id         |                          0 |
      | xid                    |                          0 |
      | match.wildcards        | {:nw_src=>24, :nw_dst=>24} |
      | match.in_port          |                          1 |
      | match.eth_src_addr     |          00:00:00:00:00:0a |
      | match.eth_dst_addr     |          00:00:00:00:00:00 |
      | match.dl_vlan          |                          0 |
      | match.dl_vlan_pcp      |                          0 |
      | match.eth_type         |                       2048 |
      | match.nw_tos           |                          0 |
      | match.nw_proto         |                          1 |
      | match.nw_src           |                   10.0.0.0 |
      | match.nw_src.prefixlen |                          8 |
      | match.nw_dst           |                   20.0.0.0 |
      | match.nw_dst.prefixlen |                          8 |
      | match.tp_src           |                          8 |
      | match.tp_dst           |                          0 |
      | cookie                 |                          0 |
      | command                |                     delete |
      | idle_timeout           |                          0 |
      | hard_timeout           |                          0 |
      | priority               |                      65535 |
      | buffer_id              |                 4294967295 |
      | out_port               |                      65535 |
      | flags                  |                         [] |
      | actions                |                         [] |

Scenario: parse (Flow Mod Delete Strict)
    When I try to parse a file named "flow_mod_delete_strict.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                  |                      value |
      | ofp_version            |                          1 |
      | message_type           |                         14 |
      | message_length         |                         72 |
      | transaction_id         |                          0 |
      | xid                    |                          0 |
      | match.wildcards        | {:nw_src=>24, :nw_dst=>24} |
      | match.in_port          |                          1 |
      | match.eth_src_addr     |          00:00:00:00:00:0a |
      | match.eth_dst_addr     |          00:00:00:00:00:14 |
      | match.dl_vlan          |                          0 |
      | match.dl_vlan_pcp      |                          0 |
      | match.eth_type         |                       2048 |
      | match.nw_tos           |                          0 |
      | match.nw_proto         |                          1 |
      | match.nw_src           |                   10.0.0.0 |
      | match.nw_src.prefixlen |                          8 |
      | match.nw_dst           |                   20.0.0.0 |
      | match.nw_dst.prefixlen |                          8 |
      | match.tp_src           |                          8 |
      | match.tp_dst           |                          0 |
      | cookie                 |                          1 |
      | command                |              delete_strict |
      | idle_timeout           |                          0 |
      | hard_timeout           |                          0 |
      | priority               |                      65535 |
      | buffer_id              |                 4294967295 |
      | out_port               |                      65535 |
      | flags                  |                         [] |
      | actions                |                         [] |
