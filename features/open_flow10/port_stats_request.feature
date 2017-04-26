@open_flow10
Feature: PortStats::Request
  Scenario: new(:none)
    When I create an OpenFlow message with:
      """
      Pio::OpenFlow10::PortStats::Request.new(:none)
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     1 |
      | transaction_id |     0 |
      | xid            |     0 |
      | stats_type     | :port |
      | port           | :none |

  Scenario: new(:none, transaction_id: 123)
    When I create an OpenFlow message with:
      """
      Pio::OpenFlow10::PortStats::Request.new(:none, transaction_id: 123)
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     1 |
      | transaction_id |   123 |
      | xid            |   123 |
      | stats_type     | :port |
      | port           | :none |
