Feature: Pio::Dhcp
  Scenario: create a DHCP Ack
    When I try to create a packet with:
    """
      Pio::Dhcp::Ack.new(
        source_mac: 'aa:bb:cc:dd:ee:ff',
        destination_mac: '11:22:33:44:55:66',
        source_ip_address: '192.168.0.10',
        destination_ip_address: '192.168.0.1',
        transaction_id: 0xdeadbeef,
        renewal_time_value: 0xdeadbeef,
        rebinding_time_value: 0xdeadbeef,
        ip_address_lease_time: 0xdeadbeef,
        subnet_mask: '255.255.255.0'
      )
      """
    Then it should finish successfully
    And the packet has the following fields and values:
    | field                  |             value |
    | class                  |    Pio::Dhcp::Ack |
    | destination_mac        | 11:22:33:44:55:66 |
    | source_mac             | aa:bb:cc:dd:ee:ff |
    | ether_type             |              2048 |
    | ip_version             |                 4 |
    | ip_header_length       |                 5 |
    | ip_type_of_service     |                 0 |
    | ip_total_length        |               328 |
    | ip_identifier          |                 0 |
    | ip_flag                |                 0 |
    | ip_fragment            |                 0 |
    | ip_ttl                 |               128 |
    | ip_protocol            |                17 |
    | ip_header_checksum     |             47177 |
    | source_ip_address      |      192.168.0.10 |
    | destination_ip_address |       192.168.0.1 |
    | udp_source_port        |                67 |
    | udp_destination_port   |                68 |
    | udp_length             |               308 |
    | udp_checksum           |              7012 |
    | message_type           |                 5 |
    | hw_addr_type           |                 1 |
    | hw_addr_len            |                 6 |
    | hops                   |                 0 |
    | transaction_id         |        3735928559 |
    | seconds                |                 0 |
    | bootp_flags            |                 0 |
    | client_ip_address      |           0.0.0.0 |
    | your_ip_address        |       192.168.0.1 |
    | next_server_ip_address |           0.0.0.0 |
    | relay_agent_ip_address |           0.0.0.0 |
    | client_mac_address     | aa:bb:cc:dd:ee:ff |
    | subnet_mask            |     255.255.255.0 |
    | server_identifier      |      192.168.0.10 |
    | renewal_time_value     |        3735928559 |
    | rebinding_time_value   |        3735928559 |
    | ip_address_lease_time  |        3735928559 |

  Scenario: create a DHCP Discover
    When I try to create a packet with:
    """
      Pio::Dhcp::Discover.new(
        source_mac: '24:db:ac:41:e5:5b',
        transaction_id: 0xdeadbeef
      )
    """
    Then it should finish successfully
    And the packet has the following fields and values:
    | field                  |               value |
    | class                  | Pio::Dhcp::Discover |
    | destination_mac        |   ff:ff:ff:ff:ff:ff |
    | source_mac             |   24:db:ac:41:e5:5b |
    | ether_type             |                2048 |
    | ip_version             |                   4 |
    | ip_header_length       |                   5 |
    | ip_type_of_service     |                   0 |
    | ip_total_length        |                 328 |
    | ip_identifier          |                   0 |
    | ip_flag                |                   0 |
    | ip_fragment            |                   0 |
    | ip_ttl                 |                 128 |
    | ip_protocol            |                  17 |
    | ip_header_checksum     |               14758 |
    | source_ip_address      |             0.0.0.0 |
    | destination_ip_address |     255.255.255.255 |
    | udp_source_port        |                  68 |
    | udp_destination_port   |                  67 |
    | udp_length             |                 308 |
    | udp_checksum           |               34836 |
    | message_type           |                   1 |
    | hw_addr_type           |                   1 |
    | hw_addr_len            |                   6 |
    | hops                   |                   0 |
    | transaction_id         |          3735928559 |
    | seconds                |                   0 |
    | bootp_flags            |                   0 |
    | client_ip_address      |             0.0.0.0 |
    | your_ip_address        |             0.0.0.0 |
    | next_server_ip_address |             0.0.0.0 |
    | relay_agent_ip_address |             0.0.0.0 |
    | client_mac_address     |   24:db:ac:41:e5:5b |
    | parameters_list        |       [1, 3, 6, 42] |
    | client_identifier      |   24:db:ac:41:e5:5b |

  Scenario: create a DHCP Request
    When I try to create a packet with:
    """
      Pio::Dhcp::Request.new(
        source_mac: '24:db:ac:41:e5:5b',
        transaction_id: 0xdeadbeef,
        server_identifier: '192.168.0.1',
        requested_ip_address: '192.168.0.10'
      )
    """
    Then it should finish successfully
    And the packet has the following fields and values:
    | field                  |              value |
    | class                  | Pio::Dhcp::Request |
    | destination_mac        |  ff:ff:ff:ff:ff:ff |
    | source_mac             |  24:db:ac:41:e5:5b |
    | ether_type             |               2048 |
    | ip_version             |                  4 |
    | ip_header_length       |                  5 |
    | ip_type_of_service     |                  0 |
    | ip_total_length        |                328 |
    | ip_identifier          |                  0 |
    | ip_flag                |                  0 |
    | ip_fragment            |                  0 |
    | ip_ttl                 |                128 |
    | ip_protocol            |                 17 |
    | ip_header_checksum     |              14758 |
    | source_ip_address      |            0.0.0.0 |
    | destination_ip_address |    255.255.255.255 |
    | udp_source_port        |                 68 |
    | udp_destination_port   |                 67 |
    | udp_length             |                308 |
    | udp_checksum           |              52915 |
    | message_type           |                  3 |
    | hw_addr_type           |                  1 |
    | hw_addr_len            |                  6 |
    | hops                   |                  0 |
    | transaction_id         |         3735928559 |
    | seconds                |                  0 |
    | bootp_flags            |                  0 |
    | client_ip_address      |            0.0.0.0 |
    | your_ip_address        |            0.0.0.0 |
    | next_server_ip_address |            0.0.0.0 |
    | relay_agent_ip_address |            0.0.0.0 |
    | client_mac_address     |  24:db:ac:41:e5:5b |
    | parameters_list        |      [1, 3, 6, 42] |
    | client_identifier      |  24:db:ac:41:e5:5b |
    | requested_ip_address   |       192.168.0.10 |

  Scenario: create a DHCP Offer
    When I try to create a packet with:
    """
      Pio::Dhcp::Offer.new(
        source_mac: 'aa:bb:cc:dd:ee:ff',
        destination_mac: '11:22:33:44:55:66',
        source_ip_address: '192.168.0.10',
        destination_ip_address: '192.168.0.1',
        transaction_id: 0xdeadbeef,
        renewal_time_value: 0xdeadbeef,
        rebinding_time_value: 0xdeadbeef,
        ip_address_lease_time: 0xdeadbeef,
        subnet_mask: '255.255.255.0'
      )
      """
    Then it should finish successfully
    And the packet has the following fields and values:
    | field                  |             value |
    | class                  |  Pio::Dhcp::Offer |
    | destination_mac        | 11:22:33:44:55:66 |
    | source_mac             | aa:bb:cc:dd:ee:ff |
    | ether_type             |              2048 |
    | ip_version             |                 4 |
    | ip_header_length       |                 5 |
    | ip_type_of_service     |                 0 |
    | ip_total_length        |               328 |
    | ip_identifier          |                 0 |
    | ip_flag                |                 0 |
    | ip_fragment            |                 0 |
    | ip_ttl                 |               128 |
    | ip_protocol            |                17 |
    | ip_header_checksum     |             47177 |
    | source_ip_address      |      192.168.0.10 |
    | destination_ip_address |       192.168.0.1 |
    | udp_source_port        |                67 |
    | udp_destination_port   |                68 |
    | udp_length             |               308 |
    | udp_checksum           |              7780 |
    | message_type           |                 2 |
    | hw_addr_type           |                 1 |
    | hw_addr_len            |                 6 |
    | hops                   |                 0 |
    | transaction_id         |        3735928559 |
    | seconds                |                 0 |
    | bootp_flags            |                 0 |
    | client_ip_address      |           0.0.0.0 |
    | your_ip_address        |       192.168.0.1 |
    | next_server_ip_address |           0.0.0.0 |
    | relay_agent_ip_address |           0.0.0.0 |
    | client_mac_address     | aa:bb:cc:dd:ee:ff |
    | subnet_mask            |     255.255.255.0 |
    | server_identifier      |      192.168.0.10 |
    | renewal_time_value     |        3735928559 |
    | rebinding_time_value   |        3735928559 |
    | ip_address_lease_time  |        3735928559 |

  Scenario: parse dhcp.pcap
    When I try to parse a file named "dhcp.pcap" with "Pio::Dhcp" class
    Then it should finish successfully
