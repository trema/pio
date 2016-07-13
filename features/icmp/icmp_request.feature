Feature: Icmp::Request
  Scenario: create an ICMP request
    When I create a packet with:
      """ruby
      Pio::Icmp::Request.new(
        source_mac: '11:22:33:44:55:66',
        destination_mac: '66:55:44:33:22:11',
        source_ip_address: '192.168.83.3',
        destination_ip_address: '192.168.83.254',
        icmp_identifier: 256,
        icmp_sequence_number: 111,
        echo_data: 'hello world'
      )
      """
    Then the packet has the following fields and values:
      | field                  |             value |
      | source_mac             | 11:22:33:44:55:66 |
      | destination_mac        | 66:55:44:33:22:11 |
      | ether_type.to_hex      |             0x800 |
      | ip_total_length        |                50 |
      | ip_protocol            |                 1 |
      | source_ip_address      |      192.168.83.3 |
      | destination_ip_address |    192.168.83.254 |
      | icmp_type              |                 8 |
      | icmp_code              |                 0 |
      | icmp_checksum          |             51394 |
      | icmp_identifier        |               256 |
      | icmp_sequence_number   |               111 |
      | echo_data              |       hello world |

  Scenario: convert an ICMP request to Ruby code
    When I eval the following Ruby code:
      """ruby
      Pio::Icmp::Request.new(
        destination_mac: '11:22:33:44:55:66',
        source_mac: '66:55:44:33:22:11',
        source_ip_address: '192.168.83.3',
        destination_ip_address: '192.168.83.254'
      ).to_ruby
      """
    Then the result of eval should be:
      """ruby
      [
        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, # destination_mac
        0x66, 0x55, 0x44, 0x33, 0x22, 0x11, # source_mac
        0x08, 0x00, # ether_type
        0b0100_0101, # ip_version, ip_header_length
        0x00, # ip_type_of_service
        0x00, 0x32, # ip_total_length
        0x00, 0x00, # ip_identifier
        0b000_0000000000000, # ip_flag, ip_fragment
        0x80, # ip_ttl
        0x01, # ip_protocol
        0x12, 0x79, # ip_header_checksum
        0xc0, 0xa8, 0x53, 0x03, # source_ip_address
        0xc0, 0xa8, 0x53, 0xfe, # destination_ip_address
        0x08, # icmp_type
        0x00, # icmp_code
        0xf7, 0xff, # icmp_checksum
        0x00, 0x00, # icmp_identifier
        0x00, 0x00, # icmp_sequence_number
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, # padding
      ].pack('C20nC42')
      """

  Scenario: Icmp::Request instance inspection
    When I create a packet with:
      """ruby
      Pio::Icmp::Request.new(
        destination_mac: '00:26:82:eb:ea:d1',
        source_mac: '00:16:9d:1d:9c:c4',
        source_ip_address: '1.2.3.4',
        destination_ip_address: '4.3.2.1'
      ).inspect
      """
    Then the result of eval should be:
      """
      #<Pio::Icmp::Request destination_mac: "00:26:82:eb:ea:d1", source_mac: "00:16:9d:1d:9c:c4", ether_type: 0x0800, ip_version: 4, ip_header_length: 5, ip_type_of_service: 0, ip_total_length: 50, ip_identifier: 0, ip_flag: 0, ip_fragment: 0, ip_ttl: 128, ip_protocol: 1, ip_header_checksum: 12482, source_ip_address: "1.2.3.4", destination_ip_address: "4.3.2.1", ip_option: "", icmp_type: 8, icmp_code: 0, icmp_checksum: 63487, icmp_identifier: 0, icmp_sequence_number: 0, echo_data: "">
      """

  Scenario: Icmp::Request class inspection
    When I eval the following Ruby code:
      """ruby
      Pio::Icmp::Request.inspect
      """
    Then the result of eval should be:
      """
      Pio::Icmp::Request(destination_mac: mac_address, source_mac: mac_address, ether_type: ether_type, vlan_pcp: bit3, vlan_cfi: bit1, vlan_vid: bit12, ether_type_vlan: uint16, ip_version: bit4, ip_header_length: bit4, ip_type_of_service: uint8, ip_total_length: uint16, ip_identifier: uint16, ip_flag: bit3, ip_fragment: bit13, ip_ttl: uint8, ip_protocol: uint8, ip_header_checksum: uint16, source_ip_address: ip_address, destination_ip_address: ip_address, ip_option: string, icmp_type: uint8, icmp_code: uint8, icmp_checksum: uint16, icmp_identifier: uint16, icmp_sequence_number: uint16, echo_data: string)
      """
