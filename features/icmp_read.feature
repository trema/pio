Feature: Pio::Icmp.read
  Scenario: icmp.pcap
    Given a packet data file "icmp.pcap"
    When I try to parse the file with "Icmp" class
    Then it should finish successfully
