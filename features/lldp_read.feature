Feature: Pio::Lldp.read
  Scenario: lldp.minimal.pcap
    Given a packet data file "lldp.minimal.pcap"
    When I try to parse the file with "Lldp" class
    Then it should finish successfully

  Scenario: lldp.detailed.pcap
    Given a packet data file "lldp.detailed.pcap"
    When I try to parse the file with "Lldp" class
    Then it should finish successfully
