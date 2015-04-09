Feature: Pio::Echo.read
  Scenario: echo_request.raw
    When I try to parse a file named "echo_request.raw" with "Echo::Request" class
    Then it should finish successfully
    And the message have the following fields and values:
    | field          |              value |
    | class          | Pio::Echo::Request |
    | ofp_version    |                  1 |
    | message_type   |                  2 |
    | message_length |                  8 |
    | transaction_id |                  0 |
    | xid            |                  0 |
    | body           |                    |

  Scenario: echo_reply.raw
    When I try to parse a file named "echo_reply.raw" with "Echo::Reply" class
    Then it should finish successfully
    And the message have the following fields and values:
    | field          |            value |
    | class          | Pio::Echo::Reply |
    | ofp_version    |                1 |
    | message_type   |                3 |
    | message_length |                8 |
    | transaction_id |                6 |
    | xid            |                6 |
    | body           |                  |

