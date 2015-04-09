Feature: Pio::Hello.read
  Scenario: hello.raw
    When I try to parse a file named "hello.raw" with "Hello" class
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
