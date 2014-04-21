Feature: Pio::Features.read
  Scenario: features_reply.raw
    Given PENDING: a packet data file "features_reply.raw"
    When I try to parse the file with "Features" class
    Then it should finish successfully
