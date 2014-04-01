Feature: Pio::Icmp.read
  Scenario: icmp.pcap
    Given a pcap file "icmp.pcap"
    When I try to parse the pcap file with "Icmp" class
    Then it should finish successfully
