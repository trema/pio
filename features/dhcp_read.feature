@announce
Feature: Pio::Dhcp.read
  Scenario: dhcp.pcap
    When I try to parse a file named "dhcp.pcap" with "Dhcp" class
    Then it should finish successfully
