@open_flow10
Feature: PacketIn

  When packets are received by the datapath and sent to the
  controller, they use the PacketIn message.

  Scenario: new
    When I create an OpenFlow message with:
      """
      arp_request = Pio::Arp::Request.new(
        source_mac: 'fa:ce:b0:00:00:cc',
        sender_protocol_address: '192.168.0.1',
        target_protocol_address: '192.168.0.2'
      )

      Pio::PacketIn.new(transaction_id: 0,
                        buffer_id: 0xffffff00,
                        in_port: 1,
                        reason: :no_match,
                        raw_data: arp_request.to_binary)
      """
    Then the message has the following fields and values:
      | field           |             value |
      | transaction_id  |                 0 |
      | xid             |                 0 |
      | buffer_id       |        4294967040 |
      | total_length    |                64 |
      | in_port         |                 1 |
      | reason          |         :no_match |
      | data.class      | Pio::Arp::Request |
      | source_mac      | fa:ce:b0:00:00:cc |
      | destination_mac | ff:ff:ff:ff:ff:ff |
