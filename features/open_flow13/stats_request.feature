Feature: StatsRequest
  Background:
    Given I use OpenFlow 1.3

  @wip
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::StatsRequest.new(stats_type: :table)
      """
    Then the message has the following fields and values:
      | field          |  value |
      | version        |      4 |
      | transaction_id |      0 |
      | xid            |      0 |
      | stats_type     | :table |
