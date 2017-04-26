@open_flow10
Feature: FlowStats::Reply
  Scenario: new
    When I create an OpenFlow message with:
      """
      Pio::FlowStats::Reply.new
      """
    Then the message has the following fields and values:
      | field          | value |
      | version        |     1 |
      | transaction_id |     0 |
      | xid            |     0 |
      | stats_type     | :flow |
      | stats.size     |     0 |

  @wip
  Scenario: new(more options)
    When I create an OpenFlow message with:
      """
      Pio::FlowStats::Reply.new(more options)
      """
