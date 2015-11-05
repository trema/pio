@open_flow10
Feature: Pio::PacketIn
  Scenario: new
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

      Pio::PacketIn.new(transaction_id: 0,
                        buffer_id: 0xffffff00,
                        in_port: 1,
                        reason: :no_match,
                        raw_data: data_dump)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                 |             value |
      | ofp_version           |                 1 |
      | message_type          |                10 |
      | message_length        |                78 |
      | transaction_id        |                 0 |
      | xid                   |                 0 |
      | buffer_id             |        4294967040 |
      | total_len             |                60 |
      | in_port               |                 1 |
      | reason                |         :no_match |
      | raw_data.length       |                60 |
      | source_mac            | ac:5d:10:31:37:79 |
      | source_mac.class      |          Pio::Mac |
      | destination_mac       | ff:ff:ff:ff:ff:ff |
      | destination_mac.class |          Pio::Mac |

  Scenario: read
    When I try to parse a file named "open_flow10/packet_in_arp_request.raw" with "PacketIn" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                 |             value |
      | ofp_version           |                 1 |
      | message_type          |                10 |
      | message_length        |                78 |
      | transaction_id        |                 0 |
      | xid                   |                 0 |
      | buffer_id             |        4294967040 |
      | total_len             |                60 |
      | in_port               |                 1 |
      | reason                |         :no_match |
      | raw_data.length       |                60 |
      | source_mac            | ac:5d:10:31:37:79 |
      | source_mac.class      |          Pio::Mac |
      | destination_mac       | ff:ff:ff:ff:ff:ff |
      | destination_mac.class |          Pio::Mac |
