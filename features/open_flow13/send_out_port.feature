@open_flow13
Feature: Pio::SendOutPort
  Scenario: new(1)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(1)
      """
    Then it should finish successfully
    And the message has the following fields and values:
      | field         |      value |
      | action_type   |          0 |
      | action_length |         16 |
      | port          |          1 |
      | max_length    | :no_buffer |

  Scenario: new(:all)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:all)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :all       |
      | max_length    | :no_buffer |

  Scenario: new(:controller)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:controller)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value       |
      | action_type   | 0           |
      | action_length | 16          |
      | port          | :controller |
      | max_length    | :no_buffer  |

  Scenario: new(:local)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:local)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :local     |
      | max_length    | :no_buffer |

  Scenario: new(:table)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:table)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :table     |
      | max_length    | :no_buffer |

  Scenario: new(:in_port)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:in_port)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :in_port   |
      | max_length    | :no_buffer |

  Scenario: new(:normal)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:normal)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :normal    |
      | max_length    | :no_buffer |

  Scenario: new(:flood)
    When I try to create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:flood)
      """
    Then it should finish successfully
    And the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :flood     |
      | max_length    | :no_buffer |

  Scenario: read
    When I try to parse a file named "open_flow13/send_out_port.raw" with "Pio::SendOutPort" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field         |      value |
      | action_type   |          0 |
      | action_length |         16 |
      | port          |          1 |
      | max_length    | :no_buffer |
