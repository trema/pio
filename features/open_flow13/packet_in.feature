@open_flow13
Feature: PacketIn
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::PacketIn.new
      """
    Then the message has the following fields and values:
      | field                   |     value |
      | version                 |         4 |
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
    When I create an OpenFlow message with:
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
    Then the message has the following fields and values:
      | field                   |             value |
      | version                 |                 4 |
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
