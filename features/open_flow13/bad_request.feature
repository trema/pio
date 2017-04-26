@open_flow13
Feature: Error::BadRequest

  Request was not understood error.

  Scenario: new (raw_data = Echo request 1.0)
    When I create an OpenFlow message with:
      """
      Pio::Error::BadRequest.new(raw_data: Pio::OpenFlow10::Echo::Request.new.to_binary)
      """
    Then the message has the following fields and values:
      | field           |        value |
      | version         |            4 |
      | transaction_id  |            0 |
      | xid             |            0 |
      | error_type      | :bad_request |
      | error_code      | :bad_version |
      | raw_data.length |            8 |

  Scenario: read
    When I parse a file named "open_flow13/bad_request.raw" with "Pio::Error::BadRequest" class
    Then the message has the following fields and values:
      | field           |        value |
      | version         |            4 |
      | transaction_id  |            0 |
      | xid             |            0 |
      | error_type      | :bad_request |
      | error_code      | :bad_version |
      | raw_data.length |            8 |
