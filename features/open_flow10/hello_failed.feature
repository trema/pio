@open_flow10
Feature: Pio::HelloFailed

  Hello protocol failed

  @wip
  Scenario: read
    When I try to parse a file named "open_flow10/hello_failed.raw" with "Hello" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |             value |
      | ofp_version    |                 1 |
      | message_type   |                 1 |
      | message_length |                29 |
      | transaction_id |                 0 |
      | xid            |                 0 |
      | description    | error description |
