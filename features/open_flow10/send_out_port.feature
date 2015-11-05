@open_flow10
Feature: Pio::SendOutPort

  Scenario: new(1)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(1)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value |
      | action_type   |     0 |
      | action_length |     8 |
      | port          |     1 |
      | max_length    | 65535 |

  Scenario: new(:all)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:all)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value |
      | action_type   |     0 |
      | action_length |     8 |
      | port          |  :all |
      | max_length    | 65535 |

  Scenario: new(:controller)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:controller)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |       value |
      | action_type   |           0 |
      | action_length |           8 |
      | port          | :controller |
      | max_length    |       65535 |

  Scenario: new(:local)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:local)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |  value |
      | action_type   |      0 |
      | action_length |      8 |
      | port          | :local |
      | max_length    |  65535 |

  Scenario: new(:table)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:table)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |  value |
      | action_type   |      0 |
      | action_length |      8 |
      | port          | :table |
      | max_length    |  65535 |

  Scenario: new(:in_port)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:in_port)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |    value |
      | action_type   |        0 |
      | action_length |        8 |
      | port          | :in_port |
      | max_length    |    65535 |

  Scenario: new(:normal)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:normal)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |   value |
      | action_type   |       0 |
      | action_length |       8 |
      | port          | :normal |
      | max_length    |   65535 |

  Scenario: new(:flood)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:flood)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         |  value |
      | action_type   |      0 |
      | action_length |      8 |
      | port          | :flood |
      | max_length    |  65535 |
