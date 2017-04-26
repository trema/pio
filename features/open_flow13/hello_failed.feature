@open_flow13
Feature: Error::HelloFailed

  Hello protocol failed

  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::Error::HelloFailed.new
      """
    And the message has the following fields and values:
      | field          |         value |
      | version        |             4 |
      | transaction_id |             0 |
      | xid            |             0 |
      | error_type     | :hello_failed |
      | error_code     | :incompatible |
      | description    |               |

  Scenario: new(description: 'error description')
    When I create an OpenFlow message with:
      """
      Pio::Error::HelloFailed.new(description: 'error description')
      """
    And the message has the following fields and values:
      | field          |             value |
      | version        |                 4 |
      | transaction_id |                 0 |
      | xid            |                 0 |
      | error_type     |     :hello_failed |
      | error_code     |     :incompatible |
      | description    | error description |

  Scenario: new(error_code: :permissions_error)
    When I create an OpenFlow message with:
      """
      Pio::Error::HelloFailed.new(error_code: :permissions_error)
      """
    And the message has the following fields and values:
      | field          |              value |
      | version        |                  4 |
      | transaction_id |                  0 |
      | xid            |                  0 |
      | error_type     |      :hello_failed |
      | error_code     | :permissions_error |
      | description    |                    |
