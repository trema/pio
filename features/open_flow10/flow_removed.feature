@open_flow10
Feature: FlowRemoved

  If the controller has requested to be notified when flows time out, the datapath
  does this with the FlowRemoved message.

  Scenario: read
    When I parse a file named "open_flow10/flow_removed.raw" with "FlowRemoved" class
    Then the message has the following fields and values:
      | field                                              | value   |
      | transaction_id                                     | 0       |
      | xid                                                | 0       |
      | match.wildcards.keys.size                          | 11      |
      | match.wildcards.fetch(:destination_mac_address)    | true    |
      | match.wildcards.fetch(:source_mac_address)         | true    |
      | match.wildcards.fetch(:ether_type)                 | true    |
      | match.wildcards.fetch(:destination_ip_address_all) | true    |
      | match.wildcards.fetch(:ip_protocol)                | true    |
      | match.wildcards.fetch(:source_ip_address_all)      | true    |
      | match.wildcards.fetch(:tos)                        | true    |
      | match.wildcards.fetch(:transport_destination_port) | true    |
      | match.wildcards.fetch(:transport_source_port)      | true    |
      | match.wildcards.fetch(:vlan_priority)              | true    |
      | match.wildcards.fetch(:vlan_vid)                   | true    |
      | cookie                                             | 1       |
      | priority                                           | 65535   |
      | reason                                             | :delete |
      | duration_sec                                       | 0       |
      | duration_nsec                                      | 0       |
      | idle_timeout                                       | 0       |
      | packet_count                                       | 0       |
      | byte_count                                         | 0       |
