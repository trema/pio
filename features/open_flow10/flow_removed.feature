@open_flow10
Feature: Pio::FlowRemoved

  @open_flow10
  Scenario: read
    When I try to parse a file named "open_flow10/flow_removed.raw" with "FlowRemoved" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                                              |   value |
      | ofp_version                                        |       1 |
      | message_type                                       |      11 |
      | message_length                                     |      88 |
      | transaction_id                                     |       0 |
      | xid                                                |       0 |
      | match.wildcards.keys.size                          |      11 |
      | match.wildcards.fetch(:destination_mac_address)    |    true |
      | match.wildcards.fetch(:source_mac_address)         |    true |
      | match.wildcards.fetch(:ether_type)                 |    true |
      | match.wildcards.fetch(:destination_ip_address_all) |    true |
      | match.wildcards.fetch(:ip_protocol)                |    true |
      | match.wildcards.fetch(:source_ip_address_all)      |    true |
      | match.wildcards.fetch(:tos)                        |    true |
      | match.wildcards.fetch(:transport_destination_port) |    true |
      | match.wildcards.fetch(:transport_source_port)      |    true |
      | match.wildcards.fetch(:vlan_priority)              |    true |
      | match.wildcards.fetch(:vlan_vid)                   |    true |
      | cookie                                             |       1 |
      | priority                                           |   65535 |
      | reason                                             | :delete |
      | duration_sec                                       |       0 |
      | duration_nsec                                      |       0 |
      | idle_timeout                                       |       0 |
      | packet_count                                       |       0 |
      | byte_count                                         |       0 |
