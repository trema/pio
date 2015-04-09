Feature: Pio::Hello.read
  Scenario: hello.raw
    Given a packet data file "hello.raw"
    When I try to parse the file with "Hello" class
    Then it should finish successfully
    And the message have the following fields and values:
    | field          |      value |
    | class          | Pio::Hello |
    | ofp_version    |          1 |
    | message_type   |          0 |
    | message_length |          8 |
    | transaction_id |         23 |
    | xid            |         23 |
    | body           |            |
