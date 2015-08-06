@open_flow13
Feature: Pio::PacketOut
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::PacketOut.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field            |      value |
      | ofp_version      |          4 |
      | message_type     |         13 |
      | message_length   |         24 |
      | to_binary.length |         24 |
      | transaction_id   |          0 |
      | xid              |          0 |
      | buffer_id        | :no_buffer |
      | in_port          |          0 |
      | actions_length   |          0 |
      | raw_data.length  |          0 |

  Scenario: new (actions = SendOutPort(1), raw_data = ARP Request)
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

      Pio::PacketOut.new(raw_data: data_dump, actions: Pio::SendOutPort.new(1))
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field                   |             value |
      | ofp_version             |                 4 |
      | message_type            |                13 |
      | message_length          |               100 |
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
      | target_hardware_address | ff:ff:ff:ff:ff:ff |
      | target_protocol_address |       192.168.2.5 |

  Scenario: read
    When I try to parse a file named "open_flow13/packet_out.raw" with "PacketOut" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                    |                        value |
      | ofp_version              |                            4 |
      | message_type             |                           13 |
      | message_length           |                          100 |
      | transaction_id           |                          123 |
      | xid                      |                          123 |
      | buffer_id                |                   :no_buffer |
      | in_port                  |                  :controller |
      | actions_length           |                           16 |
      | actions.first.class      | Pio::OpenFlow13::SendOutPort |
      | actions.first.port       |                            1 |
      | actions.first.max_length |                   :no_buffer |
      | raw_data.length          |                           60 |
      | data.class               |            Pio::Arp::Request |
      | destination_mac          |            ff:ff:ff:ff:ff:ff |
      | source_mac               |            ac:5d:10:31:37:79 |
      | ether_type               |                         2054 |
      | hardware_type            |                            1 |
      | protocol_type            |                         2048 |
      | hardware_length          |                            6 |
      | protocol_length          |                            4 |
      | operation                |                            1 |
      | sender_hardware_address  |            ac:5d:10:31:37:79 |
      | sender_protocol_address  |                192.168.2.254 |
      | target_hardware_address  |            ff:ff:ff:ff:ff:ff |
      | target_protocol_address  |                  192.168.2.5 |
      
