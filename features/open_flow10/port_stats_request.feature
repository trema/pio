Feature: Pio::OpenFlow10::PortStats::Request
  @open_flow10
  Scenario: new(:none)
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow10::PortStats::Request.new(:none)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |    16 |
      | message_length |    20 |
      | transaction_id |     0 |
      | xid            |     0 |
      | stats_type     | :port |
      | port           | :none |

  @open_flow10
  Scenario: new(:none, transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::OpenFlow10::PortStats::Request.new(:none, transaction_id: 123)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |    16 |
      | message_length |    20 |
      | transaction_id |   123 |
      | xid            |   123 |
      | stats_type     | :port |
      | port           | :none |

  @open_flow10
  Scenario: read
    When I try to parse a file named "open_flow10/port_stats_request.raw" with "PortStats::Request" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field          | value |
      | ofp_version    |     1 |
      | message_type   |    16 |
      | message_length |    20 |
      | transaction_id |   123 |
      | xid            |   123 |
      | stats_type     | :port |
      | port           | :none |
