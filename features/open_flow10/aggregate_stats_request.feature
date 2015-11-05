@open_flow10
Feature: Pio::AggregateStats::Request
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::AggregateStats::Request.new(match: Match.new(in_port: 1))
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                                              | value      |
      | ofp_version                                        | 1          |
      | message_type                                       | 16         |
      | message_length                                     | 56         |
      | transaction_id                                     | 0          |
      | xid                                                | 0          |
      | stats_type                                         | :aggregate |
      | match.in_port                                      | 1          |
      | match.wildcards.keys.size                          | 11         |
      | match.wildcards.fetch(:destination_mac_address)    | true       |
      | match.wildcards.fetch(:source_mac_address)         | true       |
      | match.wildcards.fetch(:ether_type)                 | true       |
      | match.wildcards.fetch(:destination_ip_address_all) | true       |
      | match.wildcards.fetch(:ip_protocol)                | true       |
      | match.wildcards.fetch(:source_ip_address_all)      | true       |
      | match.wildcards.fetch(:tos)                        | true       |
      | match.wildcards.fetch(:transport_destination_port) | true       |
      | match.wildcards.fetch(:transport_source_port)      | true       |
      | match.wildcards.fetch(:vlan_priority)              | true       |
      | match.wildcards.fetch(:vlan_vid)                   | true       |
      | table_id.to_hex                                    | 0xff       |
      | out_port                                           | :none      |


  Scenario: read
    When I try to parse a file named "open_flow10/aggregate_stats_request.raw" with "AggregateStats::Request" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                                              | value      |
      | ofp_version                                        | 1          |
      | message_type                                       | 16         |
      | message_length                                     | 56         |
      | transaction_id                                     | 14         |
      | xid                                                | 14         |
      | stats_type                                         | :aggregate |
      | match.wildcards.keys.size                          | 12         |
      | match.wildcards.fetch(:destination_mac_address)    | true       |
      | match.wildcards.fetch(:source_mac_address)         | true       |
      | match.wildcards.fetch(:ether_type)                 | true       |
      | match.wildcards.fetch(:in_port)                    | true       |
      | match.wildcards.fetch(:destination_ip_address_all) | true       |
      | match.wildcards.fetch(:ip_protocol)                | true       |
      | match.wildcards.fetch(:source_ip_address_all)      | true       |
      | match.wildcards.fetch(:tos)                        | true       |
      | match.wildcards.fetch(:transport_destination_port) | true       |
      | match.wildcards.fetch(:transport_source_port)      | true       |
      | match.wildcards.fetch(:vlan_priority)              | true       |
      | match.wildcards.fetch(:vlan_vid)                   | true       |
      | table_id.to_hex                                    | 0xff       |
      | out_port                                           | :none      |
  
