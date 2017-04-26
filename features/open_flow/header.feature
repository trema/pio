Feature: OpenFlow::Header

  Scenario: OpenFlow::Header#to_hex
    When I create an OpenFlow message with:
      """
      Pio::OpenFlow::Header.new(version: :OpenFlow10,
                                type: 10,
                                message_length: 18,
                                transaction_id: 0xff)
      """
    Then the message has the following fields and values:
      | field    | value                                          |
      | to_bytes | 0x01, 0x0a, 0x00, 0x12, 0x00, 0x00, 0x00, 0xff |
