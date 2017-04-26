@open_flow10
Feature: Error::HelloFailed

  Hello protocol failed error

  Scenario: new(error_code: :incompatible, description: 'error description')
    When I create an OpenFlow message with:
      """
      Pio::Error::HelloFailed.new(error_code: :incompatible,
                                  description: 'error description')
      """
    Then the message has the following fields and values:
      | field          |             value |
      | transaction_id |                 0 |
      | xid            |                 0 |
      | error_type     |     :hello_failed |
      | error_code     |     :incompatible |
      | description    | error description |

