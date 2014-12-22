Feature: Pio::PacketIn.read
  Scenario: packet_in.raw
    Given a packet data file "packet_in.raw"
    When I try to parse the file with "PacketIn" class
    Then it should finish successfully
