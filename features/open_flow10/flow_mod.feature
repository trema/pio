@open_flow10
Feature: FlowMod
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::FlowMod.new(
        actions: [],
        buffer_id: 0,
        command: :add,
        flags: [],
        hard_timeout: 0,
        idle_timeout: 0,
        match: Pio::Match.new(),
        out_port: 0,
        priority: 0
      )
      """
    Then the message has the following fields and values:
      | field                                             | value |
      | actions                                           | []    |
      | buffer_id                                         | 0     |
      | command                                           | :add  |
      | flags                                             | []    |
      | hard_timeout                                      | 0     |
      | idle_timeout                                      | 0     |
      | match.wildcards.keys.size                         | 12    |
      | match.wildcards.key?(:in_port)                    | true  |
      | match.wildcards.key?(:vlan_vid)                   | true  |
      | match.wildcards.key?(:source_mac_address)         | true  |
      | match.wildcards.key?(:destination_mac_address)    | true  |
      | match.wildcards.key?(:ether_type)                 | true  |
      | match.wildcards.key?(:ip_protocol)                | true  |
      | match.wildcards.key?(:transport_source_port)      | true  |
      | match.wildcards.key?(:transport_destination_port) | true  |
      | match.wildcards.key?(:source_ip_address_all)      | true  |
      | match.wildcards.key?(:destination_ip_address_all) | true  |
      | match.wildcards.key?(:vlan_priority)              | true  |
      | match.wildcards.key?(:tos)                        | true  |
      | out_port                                          | 0     |
      | priority                                          | 0     |
