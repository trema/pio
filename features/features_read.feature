Feature: Pio::Features.read
  Scenario: features.pcap
    Given PENDING: a pcap file "features.pcap"
    When I try to parse the pcap file with "Features" class
    Then it should finish successfully
