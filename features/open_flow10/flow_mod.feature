Feature: Flow Mod
  Scenario: parse (Flow Mod Add)
    When I try to parse a file named "flow_mod_add.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                                  |                                                 value |
      | ofp_version                            |                                                     1 |
      | message_type                           |                                                    14 |
      | message_length                         |                                                   192 |
      | transaction_id                         |                                                     0 |
      | xid                                    |                                                     0 |
      | match.wildcards                        | {:ip_source_address=>24, :ip_destination_address=>24} |
      | match.in_port                          |                                                     1 |
      | match.ether_source_address             |                                     00:00:00:00:00:0a |
      | match.ether_destination_address        |                                     00:00:00:00:00:14 |
      | match.dl_vlan                          |                                                     0 |
      | match.dl_vlan_pcp                      |                                                     0 |
      | match.ether_type                       |                                                  2048 |
      | match.ip_tos                           |                                                     0 |
      | match.ip_protocol                      |                                                     1 |
      | match.ip_source_address                |                                              10.0.0.0 |
      | match.ip_source_address.prefixlen      |                                                     8 |
      | match.ip_destination_address           |                                              20.0.0.0 |
      | match.ip_destination_address.prefixlen |                                                     8 |
      | match.transport_source_port            |                                                     8 |
      | match.tp_destination                   |                                                     0 |
      | cookie                                 |                                                     0 |
      | command                                |                                                   add |
      | idle_timeout                           |                                                     0 |
      | hard_timeout                           |                                                     0 |
      | priority                               |                                                 65535 |
      | buffer_id                              |                                            4294967295 |
      | out_port                               |                                                 65535 |
      | flags                                  |                                      [:send_flow_rem] |
      | actions.length                         |                                                    12 |
      | actions.first.class                    |                                       Pio::SetVlanVid |
      | actions.first.vlan_id                  |                                                    10 |

  Scenario: parse (Flow Mod Modify)
    When I try to parse a file named "flow_mod_modify.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                                  |                                                 value |
      | ofp_version                            |                                                     1 |
      | message_type                           |                                                    14 |
      | message_length                         |                                                   192 |
      | transaction_id                         |                                                     0 |
      | xid                                    |                                                     0 |
      | match.wildcards                        | {:ip_source_address=>24, :ip_destination_address=>24} |
      | match.in_port                          |                                                     1 |
      | match.ether_source_address             |                                     00:00:00:00:00:0a |
      | match.ether_destination_address        |                                     00:00:00:00:00:14 |
      | match.dl_vlan                          |                                                     0 |
      | match.dl_vlan_pcp                      |                                                     0 |
      | match.ether_type                       |                                                  2048 |
      | match.ip_tos                           |                                                     0 |
      | match.ip_protocol                      |                                                     1 |
      | match.ip_source_address                |                                              10.0.0.0 |
      | match.ip_source_address.prefixlen      |                                                     8 |
      | match.ip_destination_address           |                                              20.0.0.0 |
      | match.ip_destination_address.prefixlen |                                                     8 |
      | match.transport_source_port            |                                                     8 |
      | match.tp_destination                   |                                                     0 |
      | cookie                                 |                                                     0 |
      | command                                |                                                modify |
      | idle_timeout                           |                                                     0 |
      | hard_timeout                           |                                                     0 |
      | priority                               |                                                 65535 |
      | buffer_id                              |                                            4294967295 |
      | out_port                               |                                                 65535 |
      | flags                                  |                                      [:send_flow_rem] |
      | actions.length                         |                                                    12 |
      | actions.first.class                    |                                       Pio::SetVlanVid |
      | actions.first.vlan_id                  |                                                    10 |

  Scenario: parse (Flow Mod Modify Strict)
    When I try to parse a file named "flow_mod_modify_strict.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                                  |                                                 value |
      | ofp_version                            |                                                     1 |
      | message_type                           |                                                    14 |
      | message_length                         |                                                   192 |
      | transaction_id                         |                                                     0 |
      | xid                                    |                                                     0 |
      | match.wildcards                        | {:ip_source_address=>24, :ip_destination_address=>24} |
      | match.in_port                          |                                                     1 |
      | match.ether_source_address             |                                     00:00:00:00:00:0a |
      | match.ether_destination_address        |                                     00:00:00:00:00:14 |
      | match.dl_vlan                          |                                                     0 |
      | match.dl_vlan_pcp                      |                                                     0 |
      | match.ether_type                       |                                                  2048 |
      | match.ip_tos                           |                                                     0 |
      | match.ip_protocol                      |                                                     1 |
      | match.ip_source_address                |                                              10.0.0.0 |
      | match.ip_source_address.prefixlen      |                                                     8 |
      | match.ip_destination_address           |                                              20.0.0.0 |
      | match.ip_destination_address.prefixlen |                                                     8 |
      | match.transport_source_port            |                                                     8 |
      | match.tp_destination                   |                                                     0 |
      | cookie                                 |                                                     0 |
      | command                                |                                         modify_strict |
      | idle_timeout                           |                                                     0 |
      | hard_timeout                           |                                                     0 |
      | priority                               |                                                 65535 |
      | buffer_id                              |                                            4294967295 |
      | out_port                               |                                                 65535 |
      | flags                                  |                                      [:send_flow_rem] |
      | actions.length                         |                                                    12 |
      | actions.first.class                    |                                       Pio::SetVlanVid |
      | actions.first.vlan_id                  |                                                    10 |
    
  Scenario: parse (Flow Mod Delete)
    When I try to parse a file named "flow_mod_delete.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                                  |                                                 value |
      | ofp_version                            |                                                     1 |
      | message_type                           |                                                    14 |
      | message_length                         |                                                    72 |
      | transaction_id                         |                                                     0 |
      | xid                                    |                                                     0 |
      | match.wildcards                        | {:ip_source_address=>24, :ip_destination_address=>24} |
      | match.in_port                          |                                                     1 |
      | match.ether_source_address             |                                     00:00:00:00:00:0a |
      | match.ether_destination_address        |                                     00:00:00:00:00:00 |
      | match.dl_vlan                          |                                                     0 |
      | match.dl_vlan_pcp                      |                                                     0 |
      | match.ether_type                       |                                                  2048 |
      | match.ip_tos                           |                                                     0 |
      | match.ip_protocol                      |                                                     1 |
      | match.ip_source_address                |                                              10.0.0.0 |
      | match.ip_source_address.prefixlen      |                                                     8 |
      | match.ip_destination_address           |                                              20.0.0.0 |
      | match.ip_destination_address.prefixlen |                                                     8 |
      | match.transport_source_port            |                                                     8 |
      | match.tp_destination                   |                                                     0 |
      | cookie                                 |                                                     0 |
      | command                                |                                                delete |
      | idle_timeout                           |                                                     0 |
      | hard_timeout                           |                                                     0 |
      | priority                               |                                                 65535 |
      | buffer_id                              |                                            4294967295 |
      | out_port                               |                                                 65535 |
      | flags                                  |                                                    [] |
      | actions                                |                                                    [] |

  Scenario: parse (Flow Mod Delete Strict)
    When I try to parse a file named "flow_mod_delete_strict.raw" with "FlowMod" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field                                  |                                                 value |
      | ofp_version                            |                                                     1 |
      | message_type                           |                                                    14 |
      | message_length                         |                                                    72 |
      | transaction_id                         |                                                     0 |
      | xid                                    |                                                     0 |
      | match.wildcards                        | {:ip_source_address=>24, :ip_destination_address=>24} |
      | match.in_port                          |                                                     1 |
      | match.ether_source_address             |                                     00:00:00:00:00:0a |
      | match.ether_destination_address        |                                     00:00:00:00:00:14 |
      | match.dl_vlan                          |                                                     0 |
      | match.dl_vlan_pcp                      |                                                     0 |
      | match.ether_type                       |                                                  2048 |
      | match.ip_tos                           |                                                     0 |
      | match.ip_protocol                      |                                                     1 |
      | match.ip_source_address                |                                              10.0.0.0 |
      | match.ip_source_address.prefixlen      |                                                     8 |
      | match.ip_destination_address           |                                              20.0.0.0 |
      | match.ip_destination_address.prefixlen |                                                     8 |
      | match.transport_source_port            |                                                     8 |
      | match.tp_destination                   |                                                     0 |
      | cookie                                 |                                                     1 |
      | command                                |                                         delete_strict |
      | idle_timeout                           |                                                     0 |
      | hard_timeout                           |                                                     0 |
      | priority                               |                                                 65535 |
      | buffer_id                              |                                            4294967295 |
      | out_port                               |                                                 65535 |
      | flags                                  |                                                    [] |
      | actions                                |                                                    [] |
