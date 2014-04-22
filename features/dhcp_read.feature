Feature: Pio::Dhcp.read
  Scenario: dhcp.pcap
    Given a packet data file "dhcp.pcap"
    When I try to parse the file with "Dhcp" class
    Then it should finish successfully
