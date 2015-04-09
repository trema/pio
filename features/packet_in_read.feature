Feature: Pio::PacketIn.read
  Scenario: packet_in_arp_request.raw
    Given a packet data file "packet_in_arp_request.raw"
    When I try to parse the file with "PacketIn" class
    Then it should finish successfully
    And the message have the following fields and values:
    | field                 |             value |
    | class                 |     Pio::PacketIn |
    | ofp_version           |                 1 |
    | message_type          |                10 |
    | message_length        |                78 |
    | transaction_id        |                 0 |
    | xid                   |                 0 |
    | buffer_id             |        4294967040 |
    | total_len             |                60 |
    | in_port               |                 1 |
    | reason                |          no_match |
    | raw_data.length       |                60 |
    | source_mac            | ac:5d:10:31:37:79 |
    | source_mac.class      |          Pio::Mac |
    | destination_mac       | ff:ff:ff:ff:ff:ff |
    | destination_mac.class |          Pio::Mac |
