@open_flow10
Feature: FlowStats::Request

  Information about individual flows is requested with a Flow Stats
  Request message.

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::FlowStats::Request.new
      """
    Then the message has the following fields and values:
      | field                                              | value |
      | version                                            | 1     |
      | transaction_id                                     | 0     |
      | xid                                                | 0     |
      | stats_type                                         | :flow |
      | match.wildcards.keys.size                          | 12    |
      | match.wildcards.fetch(:destination_mac_address)    | true  |
      | match.wildcards.fetch(:source_mac_address)         | true  |
      | match.wildcards.fetch(:ether_type)                 | true  |
      | match.wildcards.fetch(:in_port)                    | true  |
      | match.wildcards.fetch(:destination_ip_address_all) | true  |
      | match.wildcards.fetch(:ip_protocol)                | true  |
      | match.wildcards.fetch(:source_ip_address_all)      | true  |
      | match.wildcards.fetch(:tos)                        | true  |
      | match.wildcards.fetch(:transport_destination_port) | true  |
      | match.wildcards.fetch(:transport_source_port)      | true  |
      | match.wildcards.fetch(:vlan_priority)              | true  |
      | match.wildcards.fetch(:vlan_vid)                   | true  |
      | table_id.to_hex                                    | 0xff  |
      | out_port                                           | :none |

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::FlowStats::Request.new(match: Pio::Match.new(in_port: 1))
      """
    Then the message has the following fields and values:
      | field                                              | value |
      | version                                            | 1     |
      | transaction_id                                     | 0     |
      | xid                                                | 0     |
      | stats_type                                         | :flow |
      | match.in_port                                      | 1     |
      | match.wildcards.keys.size                          | 11    |
      | match.wildcards.fetch(:destination_mac_address)    | true  |
      | match.wildcards.fetch(:source_mac_address)         | true  |
      | match.wildcards.fetch(:ether_type)                 | true  |
      | match.wildcards.fetch(:destination_ip_address_all) | true  |
      | match.wildcards.fetch(:ip_protocol)                | true  |
      | match.wildcards.fetch(:source_ip_address_all)      | true  |
      | match.wildcards.fetch(:tos)                        | true  |
      | match.wildcards.fetch(:transport_destination_port) | true  |
      | match.wildcards.fetch(:transport_source_port)      | true  |
      | match.wildcards.fetch(:vlan_priority)              | true  |
      | match.wildcards.fetch(:vlan_vid)                   | true  |
      | table_id.to_hex                                    | 0xff  |
      | out_port                                           | :none |
