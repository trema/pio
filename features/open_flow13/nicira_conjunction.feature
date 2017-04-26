@open_flow13
Feature: NiciraConjunction

  Provides conjunctive flow match.

  Scenario: new(clause: 1, n_clauses: 2, conjunction_id: 1)
    When I create an OpenFlow action with:
      """
      Pio::NiciraConjunction.new(clause: 1, n_clauses: 2, conjunction_id: 1)
      """
    Then the action has the following fields and values:
      | field          | value |
      | clause         |     1 |
      | n_clauses      |     2 |
      | conjunction_id |     1 |
