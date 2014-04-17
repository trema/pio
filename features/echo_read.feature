Feature: Pio::Echo.read
  Scenario: echo.pcap
    Given PENDING: a pcap file "echo.pcap"
    When I try to parse the pcap file with "Echo" class
    Then it should finish successfully
