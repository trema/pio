@open_flow13
Feature: NiciraConjunction

  Provides conjunctive flow match.

  Scenario: new(clause: 1, n_clauses: 2, conjunction_id: 1)
    When I try to create an OpenFlow action with:
      """
      Pio::OpenFlow::NiciraConjunction.new(clause: 1, n_clauses: 2, conjunction_id: 1)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field          | value |
      | clause         |     1 |
      | n_clauses      |     2 |
      | conjunction_id |     1 |
