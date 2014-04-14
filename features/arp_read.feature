Feature: Pio::Arp.read
  Scenario: arp.pcap
    Given a pcap file "arp.pcap"
    When I try to parse the pcap file with "Arp" class
    Then it should finish successfully

  Scenario: arp-storm.pcap
    Given a pcap file "arp-storm.pcap"
    When I try to parse the pcap file with "Arp" class
    Then it should finish successfully
