Feature: IPv4Header
  Scenario: create an IPv4 header
    When I create a packet with:
      """ruby
      IPv4Header.new(source_ip_address: '1.2.3.4',
                     destination_ip_address: '4.3.2.1')
      """
    Then the packet has the following fields and values:
      | field                  |           value |
      | class                  | Pio::IPv4Header |
      | ip_version             |               4 |
      | ip_header_length       |               5 |
      | ip_type_of_service     |               0 |
      | ip_total_length        |              20 |
      | ip_identifier          |               0 |
      | ip_flag                |               0 |
      | ip_fragment            |               0 |
      | ip_ttl                 |             128 |
      | ip_protocol            |               0 |
      | ip_header_checksum     |           12513 |
      | source_ip_address      |         1.2.3.4 |
      | destination_ip_address |         4.3.2.1 |
      | ip_option              |                 |

  Scenario: read an IPv4 header
    Given I use the fixture "ipv4_header"
    When I create a packet with:
      """ruby
      Pio::IPv4Header.read(eval(IO.read('ipv4_header.rb')))
      """
    Then the packet has the following fields and values:
      | field                  |           value |
      | class                  | Pio::IPv4Header |
      | ip_version             |               4 |
      | ip_header_length       |               5 |
      | ip_type_of_service     |               0 |
      | ip_total_length        |              20 |
      | ip_identifier          |               0 |
      | ip_flag                |               0 |
      | ip_fragment            |               0 |
      | ip_ttl                 |             128 |
      | ip_protocol            |               0 |
      | ip_header_checksum     |           12513 |
      | source_ip_address      |         1.2.3.4 |
      | destination_ip_address |         4.3.2.1 |
      | ip_option              |                 |

  Scenario: convert IPv4 header to Ruby code
    When I eval the following Ruby code:
      """ruby
      IPv4Header.new(source_ip_address: '1.2.3.4',
                     destination_ip_address: '4.3.2.1').to_ruby
      """
    Then the result of eval should be:
      """ruby
      [
        0b0100_0101, # ip_version, ip_header_length
        0x00, # ip_type_of_service
        0x00, 0x14, # ip_total_length
        0x00, 0x00, # ip_identifier
        0b000_0000000000000, # ip_flag, ip_fragment
        0x80, # ip_ttl
        0x00, # ip_protocol
        0x30, 0xe1, # ip_header_checksum
        0x01, 0x02, 0x03, 0x04, # source_ip_address
        0x04, 0x03, 0x02, 0x01, # destination_ip_address
      ].pack('C6nC12')
      """

  Scenario: IPv4Header instance inspection
    When I eval the following Ruby code:
      """ruby
      IPv4Header.new(source_ip_address: '1.2.3.4',
                     destination_ip_address: '4.3.2.1').inspect
      """
    Then the result of eval should be:
      """
      #<IPv4Header ip_version: 4, ip_header_length: 5, ip_type_of_service: 0, ip_total_length: 20, ip_identifier: 0, ip_flag: 0, ip_fragment: 0, ip_ttl: 128, ip_protocol: 0, ip_header_checksum: 12513, source_ip_address: "1.2.3.4", destination_ip_address: "4.3.2.1", ip_option: "">
      """

  Scenario: IPv4Header class inspection
    When I eval the following Ruby code:
      """ruby
      Pio::IPv4Header.inspect
      """
    Then the result of eval should be:
      """
      IPv4Header(ip_version: bit4, ip_header_length: bit4, ip_type_of_service: uint8, ip_total_length: uint16, ip_identifier: uint16, ip_flag: bit3, ip_fragment: bit13, ip_ttl: uint8, ip_protocol: uint8, ip_header_checksum: uint16, source_ip_address: ip_address, destination_ip_address: ip_address, ip_option: string)
      """
