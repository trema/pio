Feature: Pio::PacketOut.read
  Scenario: packet_out.raw
    Given a packet data file "packet_out.raw"
    When I try to parse the file with "PacketOut" class
    Then it should finish successfully
