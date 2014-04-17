Feature: Pio::Hello.read
  Scenario: hello.pcap
    Given PENDING: a pcap file "hello.pcap"
    When I try to parse the pcap file with "Hello" class
    Then it should finish successfully
