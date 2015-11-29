@open_flow13
Feature: SendOutPort
  Scenario: new(1)
    When I create an OpenFlow action with:
      """
      Pio::SendOutPort.new(1)
      """
    Then the message has the following fields and values:
      | field         |      value |
      | action_type   |          0 |
      | action_length |         16 |
      | port          |          1 |
      | max_length    | :no_buffer |

  Scenario: new(:all)
    When I create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:all)
      """
    Then the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :all       |
      | max_length    | :no_buffer |

  Scenario: new(:controller)
    When I create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:controller)
      """
    Then the action has the following fields and values:
      | field         | value       |
      | action_type   | 0           |
      | action_length | 16          |
      | port          | :controller |
      | max_length    | :no_buffer  |

  Scenario: new(:local)
    When I create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:local)
      """
    Then the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :local     |
      | max_length    | :no_buffer |

  Scenario: new(:table)
    When I create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:table)
      """
    Then the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :table     |
      | max_length    | :no_buffer |

  Scenario: new(:in_port)
    When I create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:in_port)
      """
    Then the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :in_port   |
      | max_length    | :no_buffer |

  Scenario: new(:normal)
    When I create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:normal)
      """
    Then the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :normal    |
      | max_length    | :no_buffer |

  Scenario: new(:flood)
    When I create an OpenFlow action with:
      """
      Pio::SendOutPort.new(:flood)
      """
    Then the action has the following fields and values:
      | field         | value      |
      | action_type   | 0          |
      | action_length | 16         |
      | port          | :flood     |
      | max_length    | :no_buffer |

  Scenario: read
    When I parse a file named "open_flow13/send_out_port.raw" with "Pio::SendOutPort" class
    Then the message has the following fields and values:
      | field         |      value |
      | action_type   |          0 |
      | action_length |         16 |
      | port          |          1 |
      | max_length    | :no_buffer |
