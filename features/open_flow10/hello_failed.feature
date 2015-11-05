@open_flow10
Feature: Pio::Error::HelloFailed

  Hello protocol failed

  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::Error::HelloFailed.new
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |         value |
      | ofp_version    |             1 |
      | message_type   |             1 |
      | message_length |            12 |
      | transaction_id |             0 |
      | xid            |             0 |
      | error_type     | :hello_failed |
      | error_code     | :incompatible |
      | description    |               |

  Scenario: new(description: 'error description')
    When I try to create an OpenFlow message with:
      """
      Pio::Error::HelloFailed.new(description: 'error description')
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |             value |
      | ofp_version    |                 1 |
      | message_type   |                 1 |
      | message_length |                29 |
      | transaction_id |                 0 |
      | xid            |                 0 |
      | error_type     |     :hello_failed |
      | error_code     |     :incompatible |
      | description    | error description |

  Scenario: new(error_code: :permissions_error)
    When I try to create an OpenFlow message with:
      """
      Pio::Error::HelloFailed.new(error_code: :permissions_error)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |              value |
      | ofp_version    |                  1 |
      | message_type   |                  1 |
      | message_length |                 12 |
      | transaction_id |                  0 |
      | xid            |                  0 |
      | error_type     |      :hello_failed |
      | error_code     | :permissions_error |
      | description    |                    |

  Scenario: read
    When I try to parse a file named "open_flow10/hello_failed.raw" with "Pio::Error::HelloFailed" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |             value |
      | ofp_version    |                 1 |
      | message_type   |                 1 |
      | message_length |                29 |
      | transaction_id |                 0 |
      | xid            |                 0 |
      | error_type     |     :hello_failed |
      | error_code     |     :incompatible |
      | description    | error description |
