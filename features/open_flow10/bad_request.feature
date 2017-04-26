@open_flow10
Feature: Error::BadRequest

  Request was not understood error

  Scenario: new (error_code: :bad_version, raw_data: EchoRequest 1.3)
    When I create an OpenFlow message with:
      """
      Pio::Error::BadRequest.new(error_code: :bad_version,
                                 raw_data: Pio::OpenFlow13::Echo::Request.new.to_binary)
      """
    Then the message has the following fields and values:
      | field           |        value |
      | transaction_id  |            0 |
      | xid             |            0 |
      | error_type      | :bad_request |
      | error_code      | :bad_version |
      | raw_data.length |            8 |
