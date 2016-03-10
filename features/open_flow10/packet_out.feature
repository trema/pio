@open_flow10
Feature: PacketOut
  Scenario: new
    When I create an OpenFlow message with:
      """
      arp_request = Pio::Arp::Request.new(
        source_mac: 'fa:ce:b0:00:00:cc',
        sender_protocol_address: '192.168.0.1',
        target_protocol_address: '192.168.0.2'
      )

      Pio::PacketOut.new(
        transaction_id: 0x16,
        buffer_id: 0xffffffff,
        in_port: 0xffff,
        actions: Pio::SendOutPort.new(2),
        raw_data: arp_request.to_binary
      )
      """
    Then the message has the following fields and values:
      | field                 |                        value |
      | transaction_id        |                           22 |
      | xid                   |                           22 |
      | buffer_id.to_hex      |                   0xffffffff |
      | in_port.to_hex        |                       0xffff |
      | actions.length        |                            1 |
      | actions[0].class      | Pio::OpenFlow10::SendOutPort |
      | actions[0].port       |                            2 |
      | actions[0].max_length |                        65535 |
      | raw_data.length       |                           64 |
