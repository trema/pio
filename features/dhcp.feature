Feature: Pio::Dhcp
  Scenario: parse dhcp.pcap
    When I try to parse a file named "dhcp.pcap" with "Pio::Dhcp" class
    Then it should finish successfully
