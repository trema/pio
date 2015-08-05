@open_flow13
Feature: Pio::PacketIn
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::PacketIn.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                   |     value |
      | ofp_version             |         4 |
      | message_type            |        10 |
      | message_length          |        34 |
      | transaction_id          |         0 |
      | xid                     |         0 |
      | buffer_id               |         0 |
      | total_len               |         0 |
      | reason                  | :no_match |
      | table_id                |         0 |
      | cookie                  |         0 |
      | match.match_fields.size |         0 |
      | raw_data.length         |         0 |

  Scenario: new (raw_data = ARP request)
    When I try to create an OpenFlow message with:
      """
      data_dump = [
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xac, 0x5d, 0x10, 0x31, 0x37,
        0x79, 0x08, 0x06, 0x00, 0x01, 0x08, 0x00, 0x06, 0x04, 0x00, 0x01,
        0xac, 0x5d, 0x10, 0x31, 0x37, 0x79, 0xc0, 0xa8, 0x02, 0xfe, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xc0, 0xa8, 0x02, 0x05, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00
      ].pack('C*')

      Pio::PacketIn.new(raw_data: data_dump)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                   |             value |
      | ofp_version             |                 4 |
      | message_length          |                94 |
      | transaction_id          |                 0 |
      | xid                     |                 0 |
      | buffer_id               |                 0 |
      | total_len               |                60 |
      | reason                  |         :no_match |
      | table_id                |                 0 |
      | cookie                  |                 0 |
      | match.match_fields.size |                 0 |
      | raw_data.length         |                60 |
      | source_mac              | ac:5d:10:31:37:79 |
      | destination_mac         | ff:ff:ff:ff:ff:ff |

  Scenario: read
    When I try to parse a file named "open_flow13/packet_in.raw" with "PacketIn" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                         |             value |
      | ofp_version                   |                 4 |
      | message_type                  |                10 |
      | message_length                |               102 |
      | transaction_id                |               123 |
      | xid                           |               123 |
      | buffer_id.to_hex              |        0xcafebabe |
      | total_len                     |                60 |
      | in_port                       |                 1 |
      | reason                        |         :no_match |
      | table_id                      |                 0 |
      | cookie                        |                 0 |
      | match.match_fields.size       |                 1 |
      | match.match_fields[0].in_port |                 1 |
      | raw_data.length               |                60 |
      | source_mac                    | ac:5d:10:31:37:79 |
      | destination_mac               | ff:ff:ff:ff:ff:ff |
