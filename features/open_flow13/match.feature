@open_flow13
Feature: Pio::Match
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field        | value |
      | match_fields | []    |

  Scenario: new(in_port: 1)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(in_port: 1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field   | value |
      | in_port |     1 |

  Scenario: new(metadata: 1)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(metadata: 1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field    | value |
      | metadata |     1 |

  Scenario: new(metadata: 1, metadata_mask: 1)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(metadata: 1, metadata_mask: 1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field         | value |
      | metadata      |     1 |
      | metadata_mask |     1 |

  Scenario: new(source_mac_address: '01:02:03:04:05:06')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(source_mac_address: '01:02:03:04:05:06')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |             value |
      | source_mac_address | 01:02:03:04:05:06 |

  Scenario: new(destination_mac_address: '01:02:03:04:05:06')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(destination_mac_address: '01:02:03:04:05:06')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                   |             value |
      | destination_mac_address | 01:02:03:04:05:06 |

  Scenario: new(source_mac_address: '01:02:03:04:05:06', source_mac_address_mask: 'ff:ff:ff:00:00:00')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(source_mac_address: '01:02:03:04:05:06', source_mac_address_mask: 'ff:ff:ff:00:00:00')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                   | value             |
      | source_mac_address      | 01:02:03:04:05:06 |
      | source_mac_address_mask | ff:ff:ff:00:00:00 |

  Scenario: new(destination_mac_address: '01:02:03:04:05:06', destination_mac_address_mask: 'ff:ff:ff:00:00:00')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(destination_mac_address: '01:02:03:04:05:06', destination_mac_address_mask: 'ff:ff:ff:00:00:00')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                        | value             |
      | destination_mac_address      | 01:02:03:04:05:06 |
      | destination_mac_address_mask | ff:ff:ff:00:00:00 |

  Scenario: new(ether_type: 0x0800)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field      | value |
      | ether_type |  2048 |

  Scenario: new(vlan_vid: 10)
    When I try to create an OpenFlow message with:
    """
    Pio::Match.new(vlan_vid: 10)
    """
    Then it should finish successfully
    And the message has the following fields and values:
      | field    | value |
      | vlan_vid |    10 |

  Scenario: new(vlan_vid: 10, vlan_pcp: 5)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(vlan_vid: 10, vlan_pcp: 5)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field    | value |
      | vlan_vid |    10 |
      | vlan_pcp |     5 |

  Scenario: new(eth_type: 2048, ip_dscp: 46)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2048, ip_dscp: 46)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field      | value |
      | ether_type |  2048 |
      | ip_dscp    |    46 |

  Scenario: new(eth_type: 2048, ip_ecn: 3)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2048, ip_ecn: 46)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field      | value |
      | ether_type |  2048 |
      | ip_ecn     |     3 |

  Scenario: new(ether_type: 0x0800, ipv4_source_address: '192.168.0.1')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ipv4_source_address: '192.168.0.1')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field               |       value |
      | ether_type          |        2048 |
      | ipv4_source_address | 192.168.0.1 |

  Scenario: new(ether_type: 0x0800, ipv4_destination_address: '192.168.0.1')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ipv4_destination_address: '192.168.0.1')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    |       value |
      | ether_type               |        2048 |
      | ipv4_destination_address | 192.168.0.1 |

  Scenario: new(ether_type: 0x0800, ipv4_source_address: '192.168.0.1', ivp4_source_address_mask: '255.255.0.0')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ipv4_source_address: '192.168.0.1', ipv4_source_address_mask: '255.255.0.0')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    |       value |
      | ether_type               |        2048 |
      | ipv4_source_address      | 192.168.0.1 |
      | ipv4_source_address_mask | 255.255.0.0 |

  Scenario: new(ether_type: 0x0800, ipv4_destination_address: '192.168.0.1', ivp4_destination_address_mask: '255.255.0.0')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ipv4_destination_address: '192.168.0.1', ipv4_destination_address_mask: '255.255.0.0')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                         |       value |
      | ether_type                    |        2048 |
      | ipv4_destination_address      | 192.168.0.1 |
      | ipv4_destination_address_mask | 255.255.0.0 |

  Scenario: new(ether_type: 0x0800, ip_protocol: 6, tcp_source_port: 1111)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ip_protocol: 6, tcp_source_port: 1111)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field           | value |
      | ether_type      |  2048 |
      | ip_protocol     |     6 |
      | tcp_source_port |  1111 |

  Scenario: new(ether_type: 0x0800, ip_protocol: 6, tcp_destination_port: 80)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ip_protocol: 6, tcp_destination_port: 80)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                | value |
      | ether_type           |  2048 |
      | ip_protocol          |     6 |
      | tcp_destination_port |    80 |

  Scenario: new(ether_type: 0x0800, ip_protocol: 17, udp_source_port: 2222)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ip_protocol: 17, udp_source_port: 2222)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field           | value |
      | ether_type      |  2048 |
      | ip_protocol     |    17 |
      | udp_source_port |  2222 |

  Scenario: new(ether_type: 0x0800, ip_protocol: 17, udp_destination_port: 3333)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ip_protocol: 17, udp_destination_port: 3333)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                | value |
      | ether_type           |  2048 |
      | ip_protocol          |    17 |
      | udp_destination_port |  3333 |

  Scenario: new(ether_type: 0x0800, ip_protocol: 132, sctp_source_port: 22)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ip_protocol: 132, sctp_source_port: 22)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field            | value |
      | ether_type       |  2048 |
      | ip_protocol      |   132 |
      | sctp_source_port |    22 |

  Scenario: new(ether_type: 0x0800, ip_protocol: 132, sctp_destination_port: 22)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ip_protocol: 132, sctp_destination_port: 22)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                 | value |
      | ether_type            |  2048 |
      | ip_protocol           |   132 |
      | sctp_destination_port |    22 |

  Scenario: new(ether_type: 0x0800, ip_protocol: 1, icmpv4_type: 8)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ip_protocol: 1, icmpv4_type: 8)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field       | value |
      | ether_type  |  2048 |
      | ip_protocol |     1 |
      | icmpv4_type |     8 |

  Scenario: new(ether_type: 0x0800, ip_protocol: 1, icmpv4_code: 0)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x0800, ip_protocol: 1, icmpv4_code: 0)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field       | value |
      | ether_type  |  2048 |
      | ip_protocol |     1 |
      | icmpv4_code |     0 |

  Scenario: new(eth_type: 2054, arp_operation: 1)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_operation: 1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field         | value |
      | ether_type    |  2054 |
      | arp_operation |     1 |

  Scenario: new(eth_type: 2054, arp_sender_protocol_address: '1.2.3.4')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_sender_protocol_address: '1.2.3.4')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                       |   value |
      | ether_type                  |    2054 |
      | arp_sender_protocol_address | 1.2.3.4 |

  Scenario: new(eth_type: 2054, arp_sender_protocol_address: '1.2.3.4', arp_sender_protocol_address_mask: '255.255.0.0')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_sender_protocol_address: '1.2.3.4', arp_sender_protocol_address_mask: '255.255.0.0')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                            |       value |
      | ether_type                       |        2054 |
      | arp_sender_protocol_address      |     1.2.3.4 |
      | arp_sender_protocol_address_mask | 255.255.0.0 |

  Scenario: new(eth_type: 2054, arp_target_protocol_address: '1.2.3.4')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_target_protocol_address: '1.2.3.4')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                       |   value |
      | ether_type                  |    2054 |
      | arp_target_protocol_address | 1.2.3.4 |

  Scenario: new(eth_type: 2054, arp_target_protocol_address: '1.2.3.4', arp_target_protocol_address_mask: '255.255.0.0')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_target_protocol_address: '1.2.3.4', arp_target_protocol_address_mask: '255.255.0.0')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                            |       value |
      | ether_type                       |        2054 |
      | arp_target_protocol_address      |     1.2.3.4 |
      | arp_target_protocol_address_mask | 255.255.0.0 |

  Scenario: new(eth_type: 2054, arp_sender_hardware_address: '11:22:33:44:55:66')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_sender_hardware_address: '11:22:33:44:55:66')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                       |             value |
      | ether_type                  |              2054 |
      | arp_sender_hardware_address | 11:22:33:44:55:66 |

  Scenario: new(eth_type: 2054, arp_sender_hardware_address: '11:22:33:44:55:66', arp_sender_hardware_address_mask: 'ff:ff:ff:00:00:00')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_sender_hardware_address: '11:22:33:44:55:66', arp_sender_hardware_address_mask: 'ff:ff:ff:00:00:00')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                            |             value |
      | ether_type                       |              2054 |
      | arp_sender_hardware_address      | 11:22:33:44:55:66 |
      | arp_sender_hardware_address_mask | ff:ff:ff:00:00:00 |

  Scenario: new(eth_type: 2054, arp_target_hardware_address: '11:22:33:44:55:66')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_target_hardware_address: '11:22:33:44:55:66')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                       |             value |
      | ether_type                  |              2054 |
      | arp_target_hardware_address | 11:22:33:44:55:66 |

  Scenario: new(eth_type: 2054, arp_target_hardware_address: '11:22:33:44:55:66', arp_target_hardware_address_mask: 'ff:ff:ff:00:00:00')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 2054, arp_target_hardware_address: '11:22:33:44:55:66', arp_target_hardware_address_mask: 'ff:ff:ff:00:00:00')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                            |             value |
      | ether_type                       |              2054 |
      | arp_target_hardware_address      | 11:22:33:44:55:66 |
      | arp_target_hardware_address_mask | ff:ff:ff:00:00:00 |

  Scenario: new(ether_type: 0x86dd, ipv6_source_address: '2001:db8:bd05:1d2:288a:1fc0:1:10ee')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x86dd, ipv6_source_address: '2001:db8:bd05:1d2:288a:1fc0:1:10ee')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field               | value                              |
      | ether_type          | 34525                              |
      | ipv6_source_address | 2001:db8:bd05:1d2:288a:1fc0:1:10ee |

  Scenario: new(ether_type: 0x86dd, ipv6_source_address: '2001:db8:bd05:1d2:288a:1fc0:1:10ee', ipv6_source_address_mask: 'ffff:ffff:ffff:ffff::')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x86dd, ipv6_source_address: '2001:db8:bd05:1d2:288a:1fc0:1:10ee', ipv6_source_address_mask: 'ffff:ffff:ffff:ffff::')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    | value                              |
      | ether_type               | 34525                              |
      | ipv6_source_address      | 2001:db8:bd05:1d2:288a:1fc0:1:10ee |
      | ipv6_source_address_mask | ffff:ffff:ffff:ffff::              |

  Scenario: new(ether_type: 0x86dd, ipv6_destination_address: '2001:db8:bd05:1d2:288a:1fc0:1:10ee')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x86dd, ipv6_destination_address: '2001:db8:bd05:1d2:288a:1fc0:1:10ee')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    | value                              |
      | ether_type               | 34525                              |
      | ipv6_destination_address | 2001:db8:bd05:1d2:288a:1fc0:1:10ee |

  Scenario: new(ether_type: 0x86dd, ipv6_destination_address: '2001:db8:bd05:1d2:288a:1fc0:1:10ee', ipv6_destination_address_mask: 'ffff:ffff:ffff:ffff::')
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(ether_type: 0x86dd, ipv6_destination_address: '2001:db8:bd05:1d2:288a:1fc0:1:10ee', ipv6_destination_address_mask: 'ffff:ffff:ffff:ffff::')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                         | value                              |
      | ether_type                    | 34525                              |
      | ipv6_destination_address      | 2001:db8:bd05:1d2:288a:1fc0:1:10ee |
      | ipv6_destination_address_mask | ffff:ffff:ffff:ffff::              |

  Scenario: new(tunnel_id: 1)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(tunnel_id: 1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field     | value |
      | tunnel_id |     1 |

  Scenario: new(tunnel_id: 1, tunnel_id_mask: 9223372036854775808)
    When I try to create an OpenFlow message with:
      """
      Pio::Match.new(tunnel_id: 1, tunnel_id_mask: 9223372036854775808)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |               value |
      | tunnel_id      |                   1 |
      | tunnel_id_mask | 9223372036854775808 |

  Scenario: read (file: open_flow13/oxm_no_fields.raw)
    When I try to parse a file named "open_flow13/oxm_no_fields.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field        | value |
      | match_fields | []    |

  Scenario: read (file: open_flow13/oxm_in_port_field.raw)
    When I try to parse a file named "open_flow13/oxm_in_port_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field   | value |
      | in_port |     1 |

  Scenario: read (file: open_flow13/oxm_metadata_field.raw)
    When I try to parse a file named "open_flow13/oxm_metadata_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field    | value |
      | metadata |     1 |

  Scenario: read (file: open_flow13/oxm_metadata_masked_field.raw)
    When I try to parse a file named "open_flow13/oxm_metadata_masked_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field         |                value |
      | metadata      |                    1 |
      | metadata_mask | 18446744069414584320 |

  Scenario: read (file: open_flow13/oxm_ether_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_ether_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                   | value             |
      | destination_mac_address | ff:ff:ff:ff:ff:ff |

  Scenario: read (file: open_flow13/oxm_ether_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_ether_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field              |             value |
      | source_mac_address | 01:02:03:04:05:06 |

  Scenario: read (file: open_flow13/oxm_masked_ether_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_ether_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                        | value             |
      | destination_mac_address      | ff:ff:ff:ff:ff:ff |
      | destination_mac_address_mask | ff:ff:ff:00:00:00 |

  Scenario: read (file: open_flow13/oxm_masked_ether_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_ether_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                   | value             |
      | source_mac_address      | 01:02:03:04:05:06 |
      | source_mac_address_mask | ff:ff:ff:00:00:00 |

  Scenario: read (file: open_flow13/oxm_ether_type_field.raw)
    When I try to parse a file named "open_flow13/oxm_ether_type_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field      | value |
      | ether_type |     0 |

  Scenario: read (file: open_flow13/oxm_vlan_vid_field.raw)
    When I try to parse a file named "open_flow13/oxm_vlan_vid_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field    | value |
      | vlan_vid |    10 |

  Scenario: read (file: open_flow13/oxm_vlan_pcp_field.raw)
    When I try to parse a file named "open_flow13/oxm_vlan_pcp_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field    | value |
      | vlan_vid |    10 |
      | vlan_pcp |     5 |

  Scenario: read (file: open_flow13/oxm_ip_dscp_field.raw)
    When I try to parse a file named "open_flow13/oxm_ip_dscp_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field      | value |
      | ether_type |  2048 |
      | ip_dscp    |    46 |

  Scenario: read (file: open_flow13/oxm_ip_ecn_field.raw)
    When I try to parse a file named "open_flow13/oxm_ip_ecn_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field      | value |
      | ether_type |  2048 |
      | ip_ecn     |     3 |

  Scenario: read (file: open_flow13/oxm_ipv4_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_ipv4_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field               |   value |
      | ether_type          |    2048 |
      | ipv4_source_address | 1.2.3.4 |

  Scenario: read (file: open_flow13/oxm_ipv4_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_ipv4_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    |       value |
      | ether_type               |        2048 |
      | ipv4_destination_address | 11.22.33.44 |

  Scenario: read (file: open_flow13/oxm_masked_ipv4_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_ipv4_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    |       value |
      | ether_type               |        2048 |
      | ipv4_source_address      |     1.2.3.4 |
      | ipv4_source_address_mask | 255.255.0.0 |

  Scenario: read (file: open_flow13/oxm_masked_ipv4_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_ipv4_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                         |         value |
      | ether_type                    |          2048 |
      | ipv4_destination_address      |   11.22.33.44 |
      | ipv4_destination_address_mask | 255.255.255.0 |

  Scenario: read (file: open_flow13/oxm_tcp_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_tcp_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field           | value |
      | ether_type      |  2048 |
      | ip_protocol     |     6 |
      | tcp_source_port |  1111 |

  Scenario: read (file: open_flow13/oxm_tcp_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_tcp_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                | value |
      | ether_type           |  2048 |
      | ip_protocol          |     6 |
      | tcp_destination_port |    80 |

  Scenario: read (file: open_flow13/oxm_udp_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_udp_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field           | value |
      | ether_type      |  2048 |
      | ip_protocol     |    17 |
      | udp_source_port |  2222 |

  Scenario: read (file: open_flow13/oxm_udp_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_udp_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                | value |
      | ether_type           |  2048 |
      | ip_protocol          |    17 |
      | udp_destination_port |  3333 |

  Scenario: read (file: open_flow13/oxm_sctp_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_sctp_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field            | value |
      | ether_type       |  2048 |
      | ip_protocol      |   132 |
      | sctp_source_port |    22 |

  Scenario: read (file: open_flow13/oxm_sctp_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_sctp_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                 | value |
      | ether_type            |  2048 |
      | ip_protocol           |   132 |
      | sctp_destination_port |    22 |

  Scenario: read (file: open_flow13/oxm_icmpv4_type_field.raw)
    When I try to parse a file named "open_flow13/oxm_icmpv4_type_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field       | value |
      | ether_type  |  2048 |
      | ip_protocol |     1 |
      | icmpv4_type |     8 |

  Scenario: read (file: open_flow13/oxm_icmpv4_code_field.raw)
    When I try to parse a file named "open_flow13/oxm_icmpv4_code_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field       | value |
      | ether_type  |  2048 |
      | ip_protocol |     1 |
      | icmpv4_code |     0 |

  Scenario: read (file: open_flow13/oxm_arp_op_field.raw)
    When I try to parse a file named "open_flow13/oxm_arp_op_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field         | value |
      | ether_type    |  2054 |
      | arp_operation |     1 |

  Scenario: read (file: open_flow13/oxm_arp_spa_field.raw)
    When I try to parse a file named "open_flow13/oxm_arp_spa_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                       |   value |
      | ether_type                  |    2054 |
      | arp_sender_protocol_address | 1.2.3.4 |

  Scenario: read (file: open_flow13/oxm_masked_arp_spa_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_arp_spa_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                            |       value |
      | ether_type                       |        2054 |
      | arp_sender_protocol_address      |     1.2.3.4 |
      | arp_sender_protocol_address_mask | 255.255.0.0 |

  Scenario: read (file: open_flow13/oxm_arp_tpa_field.raw)
    When I try to parse a file named "open_flow13/oxm_arp_tpa_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                       |   value |
      | ether_type                  |    2054 |
      | arp_target_protocol_address | 1.2.3.4 |

  Scenario: read (file: open_flow13/oxm_masked_arp_tpa_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_arp_tpa_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                            |       value |
      | ether_type                       |        2054 |
      | arp_target_protocol_address      |     1.2.3.4 |
      | arp_target_protocol_address_mask | 255.255.0.0 |

  Scenario: read (file: open_flow13/oxm_arp_sha_field.raw)
    When I try to parse a file named "open_flow13/oxm_arp_sha_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
    | field                       |             value |
    | ether_type                  |              2054 |
    | arp_sender_hardware_address | 11:22:33:44:55:66 |

  Scenario: read (file: open_flow13/oxm_masked_arp_sha_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_arp_sha_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                            |             value |
      | ether_type                       |              2054 |
      | arp_sender_hardware_address      | 11:22:33:44:55:66 |
      | arp_sender_hardware_address_mask | ff:ff:ff:ff:ff:ff |

  Scenario: read (file: open_flow13/oxm_arp_tha_field.raw)
    When I try to parse a file named "open_flow13/oxm_arp_tha_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                       |             value |
      | ether_type                  |              2054 |
      | arp_target_hardware_address | 11:22:33:44:55:66 |

  Scenario: read (file: open_flow13/oxm_masked_arp_tha_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_arp_tha_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                            |             value |
      | ether_type                       |              2054 |
      | arp_target_hardware_address      | 11:22:33:44:55:66 |
      | arp_target_hardware_address_mask | ff:ff:ff:ff:ff:ff |

  Scenario: read (file: open_flow13/oxm_ipv6_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_ipv6_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field               | value                              |
      | ether_type          | 34525                              |
      | ipv6_source_address | 2001:db8:bd05:1d2:288a:1fc0:1:10ee |

  Scenario: read (file: open_flow13/oxm_masked_ipv6_source_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_ipv6_source_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    | value                              |
      | ether_type               | 34525                              |
      | ipv6_source_address      | 2001:db8:bd05:1d2:288a:1fc0:1:10ee |
      | ipv6_source_address_mask | ffff:ffff:ffff:ffff::              |

  Scenario: read (file: open_flow13/oxm_ipv6_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_ipv6_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    | value                              |
      | ether_type               | 34525                              |
      | ipv6_destination_address | 2001:db8:bd05:1d2:288a:1fc0:1:10ee |

  Scenario: read (file: open_flow13/oxm_masked_ipv6_destination_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_ipv6_destination_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                         | value                              |
      | ether_type                    | 34525                              |
      | ipv6_destination_address      | 2001:db8:bd05:1d2:288a:1fc0:1:10ee |
      | ipv6_destination_address_mask | ffff:ffff:ffff:ffff::              |

  Scenario: read (file: open_flow13/oxm_tunnel_id_field.raw)
    When I try to parse a file named "open_flow13/oxm_tunnel_id_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field     | value |
      | tunnel_id |     1 |

  Scenario: read (file: open_flow13/oxm_masked_tunnel_id_field.raw)
    When I try to parse a file named "open_flow13/oxm_masked_tunnel_id_field.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |               value |
      | tunnel_id      |                   1 |
      | tunnel_id_mask | 9223372036854775808 |

  Scenario: read (file: open_flow13/oxm_invalid_field.raw)
    When I try to parse a file named "open_flow13/oxm_invalid_field.raw" with "Pio::Match" class
    Then it should fail with "RuntimeError", "Unknown OXM field value: 40"

  Scenario: read (file: open_flow13/oxm_experimenter_stratos_basic_dot11.raw)
    When I try to parse a file named "open_flow13/oxm_experimenter_stratos_basic_dot11.raw" with "Pio::Match" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                                |      value |
      | match_fields.at(0).oxm_field         |          0 |
      | match_fields.at(0).experimenter      | 4278247501 |
      | match_fields.at(0).data.unpack('C*') |  [0, 1, 1] |
