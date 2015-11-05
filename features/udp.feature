Feature: Pio::Udp
  Scenario: parse dhcp.pcap
    When I try to parse a file named "dhcp.pcap" with "Pio::Udp" class
    Then it should finish successfully
    And the message #1 have the following fields and values:
    | field                  |             value |
    | class                  |          Pio::Udp |
    | destination_mac        | ff:ff:ff:ff:ff:ff |
    | source_mac             | 00:0b:82:01:fc:42 |
    | ether_type             |              2048 |
    | ip_version             |                 4 |
    | ip_header_length       |                 5 |
    | ip_type_of_service     |                 0 |
    | ip_total_length        |               300 |
    | ip_identifier          |             43062 |
    | ip_flag                |                 0 |
    | ip_fragment            |                 0 |
    | ip_ttl                 |               250 |
    | ip_protocol            |                17 |
    | ip_header_checksum     |              6027 |
    | source_ip_address      |           0.0.0.0 |
    | destination_ip_address |   255.255.255.255 |
    | ip_option              |                   |
    | udp_source_port        |                68 |
    | udp_destination_port   |                67 |
    | udp_length             |               280 |
    | udp_checksum           |             22815 |
    | udp_payload.length     |               272 |
