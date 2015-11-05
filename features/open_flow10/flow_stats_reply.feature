@open_flow10
Feature: Pio::FlowStats::Reply
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::FlowStats::Reply.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |    17 |
      | message_length |    12 |
      | transaction_id |     0 |
      | xid            |     0 |
      | stats_type     | :flow |
      | stats.size     |     0 |

  @wip
  Scenario: new(more options)
    When I try to create an OpenFlow message with:
      """
      Pio::FlowStats::Reply.new(more options)
      """
    Then it should finish successfully

  Scenario: read
    When I try to parse a file named "open_flow10/flow_stats_reply.raw" with "FlowStats::Reply" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                                                       |                        value |
      | ofp_version                                                 |                            1 |
      | message_type                                                |                           17 |
      | message_length                                              |                          228 |
      | transaction_id                                              |                            6 |
      | xid                                                         |                            6 |
      | stats_type                                                  |                        :flow |
      | stats.size                                                  |                            2 |
      | stats[0].entry_length                                       |                          104 |
      | stats[0].table_id                                           |                            3 |
      | stats[0].match.wildcards.keys.size                          |                           14 |
      | stats[0].match.wildcards.fetch(:destination_mac_address)    |                         true |
      | stats[0].match.wildcards.fetch(:source_mac_address)         |                         true |
      | stats[0].match.wildcards.fetch(:ether_type)                 |                         true |
      | stats[0].match.wildcards.fetch(:in_port)                    |                         true |
      | stats[0].match.wildcards.fetch(:destination_ip_address)     |                           31 |
      | stats[0].match.wildcards.fetch(:destination_ip_address_all) |                         true |
      | stats[0].match.wildcards.fetch(:ip_protocol)                |                         true |
      | stats[0].match.wildcards.fetch(:source_ip_address)          |                           31 |
      | stats[0].match.wildcards.fetch(:source_ip_address_all)      |                         true |
      | stats[0].match.wildcards.fetch(:tos)                        |                         true |
      | stats[0].match.wildcards.fetch(:transport_destination_port) |                         true |
      | stats[0].match.wildcards.fetch(:transport_source_port)      |                         true |
      | stats[0].match.wildcards.fetch(:vlan_priority)              |                         true |
      | stats[0].match.wildcards.fetch(:vlan_vid)                   |                         true |
      | stats[0].duration_sec                                       |                            1 |
      | stats[0].duration_nsec                                      |                            2 |
      | stats[0].priority                                           |                          100 |
      | stats[0].idle_timeout                                       |                            5 |
      | stats[0].hard_timeout                                       |                           10 |
      | stats[0].cookie.to_hex                                      |            0x123456789abcdef |
      | stats[0].packet_count                                       |                           10 |
      | stats[0].byte_count                                         |                         1000 |
      | stats[0].actions.length                                     |                            2 |
      | stats[0].actions[0].class                                   | Pio::OpenFlow10::SendOutPort |
      | stats[0].actions[0].port                                    |                            1 |
      | stats[0].actions[0].max_length                              |                            0 |
      | stats[0].actions[1].class                                   | Pio::OpenFlow10::SendOutPort |
      | stats[0].actions[1].port                                    |                            2 |
      | stats[0].actions[1].max_length                              |                            0 |
      | stats[1].entry_length                                       |                          112 |
      | stats[1].table_id                                           |                            4 |
      | stats[1].match.wildcards.keys.size                          |                           14 |
      | stats[1].match.wildcards.fetch(:destination_mac_address)    |                         true |
      | stats[1].match.wildcards.fetch(:source_mac_address)         |                         true |
      | stats[1].match.wildcards.fetch(:ether_type)                 |                         true |
      | stats[1].match.wildcards.fetch(:in_port)                    |                         true |
      | stats[1].match.wildcards.fetch(:destination_ip_address)     |                           31 |
      | stats[1].match.wildcards.fetch(:destination_ip_address_all) |                         true |
      | stats[1].match.wildcards.fetch(:ip_protocol)                |                         true |
      | stats[1].match.wildcards.fetch(:source_ip_address)          |                           31 |
      | stats[1].match.wildcards.fetch(:source_ip_address_all)      |                         true |
      | stats[1].match.wildcards.fetch(:tos)                        |                         true |
      | stats[1].match.wildcards.fetch(:transport_destination_port) |                         true |
      | stats[1].match.wildcards.fetch(:transport_source_port)      |                         true |
      | stats[1].match.wildcards.fetch(:vlan_priority)              |                         true |
      | stats[1].match.wildcards.fetch(:vlan_vid)                   |                         true |
      | stats[1].duration_sec                                       |                            1 |
      | stats[1].duration_nsec                                      |                            2 |
      | stats[1].priority                                           |                          100 |
      | stats[1].idle_timeout                                       |                            5 |
      | stats[1].hard_timeout                                       |                           10 |
      | stats[1].cookie.to_hex                                      |            0x123456789abcdef |
      | stats[1].packet_count                                       |                           10 |
      | stats[1].byte_count                                         |                         1000 |
      | stats[1].actions.length                                     |                            3 |
      | stats[1].actions[0].class                                   | Pio::OpenFlow10::SendOutPort |
      | stats[1].actions[0].port                                    |                            1 |
      | stats[1].actions[0].max_length                              |                            0 |
      | stats[1].actions[1].class                                   | Pio::OpenFlow10::SendOutPort |
      | stats[1].actions[1].port                                    |                            2 |
      | stats[1].actions[1].max_length                              |                            0 |
      | stats[1].actions[2].class                                   | Pio::OpenFlow10::SendOutPort |
      | stats[1].actions[2].port                                    |                            3 |
      | stats[1].actions[2].max_length                              |                            0 |
