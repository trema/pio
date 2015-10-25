@open_flow13
Feature: Pio::Error::BadRequest

  Request was not understood error.

  Scenario: new (raw_data = Echo request 1.0)
    When I try to create an OpenFlow message with:
      """
      Pio::Error::BadRequest.new(raw_data: Pio::OpenFlow10::Echo::Request.new.to_binary)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field           |        value |
      | ofp_version     |            4 |
      | message_type    |            1 |
      | message_length  |           20 |
      | transaction_id  |            0 |
      | xid             |            0 |
      | error_type      | :bad_request |
      | error_code      | :bad_version |
      | raw_data.length |            8 |

  Scenario: read
    When I try to parse a file named "open_flow13/bad_request.raw" with "Pio::Error::BadRequest" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field           |        value |
      | ofp_version     |            4 |
      | message_type    |            1 |
      | message_length  |           20 |
      | transaction_id  |            0 |
      | xid             |            0 |
      | error_type      | :bad_request |
      | error_code      | :bad_version |
      | raw_data.length |            8 |
