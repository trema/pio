Feature: Pio::Dhcp.read
  Scenario: dhcp.pcap
    Given a pcap file "dhcp.pcap"
    When I try to parse the pcap file with "Dhcp" class
    Then it should finish successfully
