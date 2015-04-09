Feature: DHCP
  Scenario: dhcp.pcap
    When I try to parse a file named "dhcp.pcap" with "Dhcp" class
    Then it should finish successfully
