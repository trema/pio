@open_flow13
Feature: PacketOut
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::PacketOut.new
      """
    Then the message has the following fields and values:
      | field            |      value |
      | version          |          4 |
      | to_binary.length |         24 |
      | transaction_id   |          0 |
      | xid              |          0 |
      | buffer_id        | :no_buffer |
      | in_port          |          0 |
      | actions_length   |          0 |
      | raw_data.length  |          0 |

  Scenario: new (actions = SendOutPort(1), raw_data = ARP Request)
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

      Pio::PacketOut.new(raw_data: data_dump, actions: Pio::SendOutPort.new(1))
      """
    Then the message has the following fields and values:
      | field                   |             value |
      | version                 |                 4 |
      | to_binary.length        |               100 |
      | transaction_id          |                 0 |
      | xid                     |                 0 |
      | buffer_id               |        :no_buffer |
      | in_port                 |                 0 |
      | actions_length          |                16 |
      | raw_data.length         |                60 |
      | data.class              | Pio::Arp::Request |
      | destination_mac         | ff:ff:ff:ff:ff:ff |
      | source_mac              | ac:5d:10:31:37:79 |
      | ether_type              |              2054 |
      | hardware_type           |                 1 |
      | protocol_type           |              2048 |
      | hardware_length         |                 6 |
      | protocol_length         |                 4 |
      | operation               |                 1 |
      | sender_hardware_address | ac:5d:10:31:37:79 |
      | sender_protocol_address |     192.168.2.254 |
      | target_hardware_address | 00:00:00:00:00:00 |
      | target_protocol_address |       192.168.2.5 |
