Feature: Pio::Arp.read
  Scenario: arp.pcap
    Given a packet data file "arp.pcap"
    When I try to parse the file with "Arp" class
    Then it should finish successfully

  Scenario: arp-storm.pcap
    Given a packet data file "arp-storm.pcap"
    When I try to parse the file with "Arp" class
    Then it should finish successfully
