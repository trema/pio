Feature: Pio::Features.read
  Scenario: features_request.raw
    Given a packet data file "features_request.raw"
    When I try to parse the file with "Features" class
    Then it should finish successfully

  Scenario: features_reply.raw
    Given a packet data file "features_reply.raw"
    When I try to parse the file with "Features" class
    Then it should finish successfully
