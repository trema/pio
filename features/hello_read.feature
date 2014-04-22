Feature: Pio::Hello.read
  Scenario: hello.raw
    Given PENDING: a packet data file "hello.raw"
    When I try to parse the file with "Hello" class
    Then it should finish successfully
