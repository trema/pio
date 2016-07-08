Feature: Icmp::Reply
  Scenario: create an ICMP reply
    When I create a packet with:
      """
      Pio::Icmp::Reply.new(
        source_mac: '00:26:82:eb:ea:d1',
        destination_mac: '00:16:9d:1d:9c:c4',
        source_ip_address: '192.168.83.254',
        destination_ip_address: '192.168.83.3',
        identifier: 256,
        sequence_number: 0
      )
      """
    Then the packet has the following fields and values:
      | field                  |             value |
      | class                  |  Pio::Icmp::Reply |
      | destination_mac        | 00:16:9d:1d:9c:c4 |
      | source_mac             | 00:26:82:eb:ea:d1 |
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
      | source_ip_address      |    192.168.83.254 |
      | destination_ip_address |      192.168.83.3 |
      | ip_option              |                   |
      | icmp_type              |                 0 |
      | icmp_code              |                 0 |
      | icmp_checksum          |             65279 |
      | icmp_identifier        |               256 |
      | icmp_sequence_number   |                 0 |
      | echo_data              |                   |

  Scenario: Icmp::Reply instance inspection
    When I create a packet with:
      """
      Pio::Icmp::Reply.new(
        destination_mac: '00:26:82:eb:ea:d1',
        source_mac: '00:16:9d:1d:9c:c4',
        source_ip_address: '1.2.3.4',
        destination_ip_address: '4.3.2.1',
        identifier: 256,
        sequence_number: 0
      ).inspect
      """
    Then the result of eval should be:
      """
      #<Icmp::Reply destination_mac: "00:26:82:eb:ea:d1", source_mac: "00:16:9d:1d:9c:c4", ether_type: 2048, ip_version: 4, ip_header_length: 5, ip_type_of_service: 0, ip_total_length: 50, ip_identifier: 0, ip_flag: 0, ip_fragment: 0, ip_ttl: 128, ip_protocol: 1, ip_header_checksum: 12482, source_ip_address: "1.2.3.4", destination_ip_address: "4.3.2.1", ip_option: "", icmp_type: 0, icmp_code: 0, icmp_checksum: 65279, icmp_identifier: 256, icmp_sequence_number: 0, echo_data: "">
      """

  Scenario: Icmp::Reply class inspection
    When I eval the following Ruby code:
      """ruby
      Pio::Icmp::Reply.inspect
      """
    Then the result of eval should be:
      """
      Icmp::Reply(destination_mac: mac_address, source_mac: mac_address, ether_type: uint16, vlan_pcp: bit3, vlan_cfi: bit1, vlan_vid: bit12, ip_version: bit4, ip_header_length: bit4, ip_type_of_service: uint8, ip_total_length: uint16, ip_identifier: uint16, ip_flag: bit3, ip_fragment: bit13, ip_ttl: uint8, ip_protocol: uint8, ip_header_checksum: uint16, source_ip_address: ip_address, destination_ip_address: ip_address, ip_option: string, icmp_type: uint8, icmp_code: uint8, icmp_checksum: uint16, icmp_identifier: uint16, icmp_sequence_number: uint16, echo_data: string)
      """
