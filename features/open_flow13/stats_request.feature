Feature: Pio::StatsRequest
  Background:
    Given I use OpenFlow 1.3

  @wip
  Scenario: new
    When I try to create an OpenFlow message with:
      """
      Pio::StatsRequest.new(stats_type: :table)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field          |  value |
      | ofp_version    |      4 |
      | message_type   |     16 |
      | message_length |     12 |
      | transaction_id |      0 |
      | xid            |      0 |
      | stats_type     | :table |
