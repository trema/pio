Feature: Icmp
  Scenario: read an ICMP request
    Given I use the fixture "icmp"
    When I create a packet with:
      """ruby
      Pio::Icmp.read(eval(IO.read('icmp_request.rb')))
      """
    Then the packet has the following fields and values:
      | field                  |              value |
      | class                  | Pio::Icmp::Request |
      | destination_mac        |  11:22:33:44:55:66 |
      | source_mac             |  66:55:44:33:22:11 |
      | ether_type             |               2048 |
      | ip_version             |                  4 |
      | ip_header_length       |                  5 |
      | ip_type_of_service     |                  0 |
      | ip_total_length        |                 50 |
      | ip_identifier          |                  0 |
      | ip_flag                |                  0 |
      | ip_fragment            |                  0 |
      | ip_ttl                 |                128 |
      | ip_protocol            |                  1 |
      | ip_header_checksum     |               4729 |
      | source_ip_address      |       192.168.83.3 |
      | destination_ip_address |     192.168.83.254 |
      | ip_option              |                    |
      | icmp_type              |                  8 |
      | icmp_code              |                  0 |
      | icmp_checksum          |              63231 |
      | icmp_identifier        |                256 |
      | icmp_sequence_number   |                  0 |
      | echo_data.length       |                 22 |

  Scenario: read an ICMP reply
    Given I use the fixture "icmp"
    When I create a packet with:
      """ruby
      Pio::Icmp.read(eval(IO.read('icmp_reply.rb')))
      """
    Then the packet has the following fields and values:
      | field                  |             value |
      | class                  |  Pio::Icmp::Reply |
      | destination_mac        | 11:22:33:44:55:66 |
      | source_mac             | 66:55:44:33:22:11 |
      | ether_type             |              2048 |
      | ip_version             |                 4 |
      | ip_header_length       |                 5 |
      | ip_type_of_service     |                 0 |
      | ip_total_length        |                50 |
      | ip_identifier          |                 0 |
      | ip_flag                |                 0 |
      | ip_fragment            |                 0 |
      | ip_ttl                 |               128 |
      | ip_protocol            |                 1 |
      | ip_header_checksum     |              4729 |
      | source_ip_address      |      192.168.83.3 |
      | destination_ip_address |    192.168.83.254 |
      | ip_option              |                   |
      | icmp_type              |                 0 |
      | icmp_code              |                 0 |
      | icmp_checksum          |             65279 |
      | icmp_identifier        |               256 |
      | icmp_sequence_number   |                 0 |
      | echo_data.length       |                22 |
