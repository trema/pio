Feature: Icmp
  Background:
    Given I use the fixture "icmp"

  Scenario: read an ICMP request
    When I create a packet with:
      """ruby
      Pio::Icmp.read(eval(IO.read('icmp_request.rb')))
      """
    Then the packet has the following fields and values:
      | field                  |                      value |
      | class                  |         Pio::Icmp::Request |
      | destination_mac        |          11:22:33:44:55:66 |
      | source_mac             |          66:55:44:33:22:11 |
      | ether_type.to_hex      |                      0x800 |
      | ip_total_length        |                         54 |
      | ip_protocol            |                          1 |
      | source_ip_address      |               192.168.83.3 |
      | destination_ip_address |             192.168.83.254 |
      | icmp_type              |                          8 |
      | icmp_code              |                          0 |
      | icmp_checksum          |                      26613 |
      | icmp_identifier        |                        256 |
      | icmp_sequence_number   |                        111 |
      | echo_data              | abcdefghijklmnopqrstuvwxyz |

  Scenario: read an ICMP reply
    When I create a packet with:
      """ruby
      Pio::Icmp.read(eval(IO.read('icmp_reply.rb')))
      """
    Then the packet has the following fields and values:
      | field                  |                      value |
      | class                  |           Pio::Icmp::Reply |
      | destination_mac        |          11:22:33:44:55:66 |
      | source_mac             |          66:55:44:33:22:11 |
      | ether_type.to_hex      |                      0x800 |
      | ip_total_length        |                         54 |
      | ip_protocol            |                          1 |
      | source_ip_address      |             192.168.83.254 |
      | destination_ip_address |               192.168.83.3 |
      | icmp_type              |                          0 |
      | icmp_code              |                          0 |
      | icmp_checksum          |                      28661 |
      | icmp_identifier        |                        256 |
      | icmp_sequence_number   |                        111 |
      | echo_data              | abcdefghijklmnopqrstuvwxyz |
