Feature: Pio::Echo.read
  Scenario: echo.raw
    Given PENDING: a packet data file "echo.raw"
    When I try to parse the file with "Echo" class
    Then it should finish successfully
