Feature: Pio::Icmp.read
  Scenario: icmp.pcap
    Given a packet data file "icmp.pcap"
    When I try to parse the file with "Icmp" class
    Then it should finish successfully
    And the message #1 have the following field and value:
    | field                  |                            value |
    | class                  |               Pio::Icmp::Request |
    | destination_mac        |                00:13:46:0b:22:ba |
    | source_mac             |                00:16:ce:6e:8b:24 |
    | ether_type             |                             2048 |
    | ip_version             |                                4 |
    | ip_header_length       |                                5 |
    | ip_type_of_service     |                                0 |
    | ip_total_length        |                               60 |
    | ip_identifier          |                            36507 |
    | ip_flag                |                                0 |
    | ip_fragment            |                                0 |
    | ip_ttl                 |                              128 |
    | ip_protocol            |                                1 |
    | ip_header_checksum     |                            10850 |
    | ip_source_address      |                    192.168.0.114 |
    | ip_destination_address |                      192.168.0.1 |
    | ip_option              |                                  |
    | icmp_type              |                                8 |
    | icmp_code              |                                0 |
    | icmp_checksum          |                            18780 |
    | icmp_identifier        |                              768 |
    | icmp_sequence_number   |                              256 |
    | echo_data              | abcdefghijklmnopqrstuvwabcdefghi |
    And the message #2 have the following field and value:
    | field                  |                            value |
    | class                  |                 Pio::Icmp::Reply |
    | destination_mac        |                00:16:ce:6e:8b:24 |
    | source_mac             |                00:13:46:0b:22:ba |
    | ether_type             |                             2048 |
    | ip_version             |                                4 |
    | ip_header_length       |                                5 |
    | ip_type_of_service     |                                0 |
    | ip_total_length        |                               60 |
    | ip_identifier          |                            24150 |
    | ip_flag                |                                0 |
    | ip_fragment            |                                0 |
    | ip_ttl                 |                              127 |
    | ip_protocol            |                                1 |
    | ip_header_checksum     |                            23463 |
    | ip_source_address      |                      192.168.0.1 |
    | ip_destination_address |                    192.168.0.114 |
    | ip_option              |                                  |
    | icmp_type              |                                0 |
    | icmp_code              |                                0 |
    | icmp_checksum          |                            20828 |
    | icmp_identifier        |                              768 |
    | icmp_sequence_number   |                              256 |
    | echo_data              | abcdefghijklmnopqrstuvwabcdefghi |
