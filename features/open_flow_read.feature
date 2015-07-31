Feature: Pio::OpenFlow.read
  Scenario: Hello
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    When I try to parse a file named "open_flow10/hello.raw" with "OpenFlow" class
    Then it should finish successfully
    And the message should be a "Pio::OpenFlow10::Hello"

  Scenario: Echo::Request
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    When I try to parse a file named "open_flow10/echo_request.raw" with "OpenFlow" class
    Then it should finish successfully
    And the message should be a "Pio::OpenFlow10::Echo::Request"

  Scenario: Echo::Reply
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    When I try to parse a file named "open_flow10/echo_reply.raw" with "OpenFlow" class
    Then it should finish successfully
    And the message should be a "Pio::OpenFlow10::Echo::Reply"

  Scenario: Features::Request
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    When I try to parse a file named "open_flow10/features_request.raw" with "OpenFlow" class
    Then it should finish successfully
    And the message should be a "Pio::OpenFlow10::Features::Request"

  Scenario: Features::Reply
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    When I try to parse a file named "open_flow10/features_reply.raw" with "OpenFlow" class
    Then it should finish successfully
    And the message should be a "Pio::OpenFlow10::Features::Reply"

  Scenario: PacketIn
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    When I try to parse a file named "open_flow10/packet_in.raw" with "OpenFlow" class
    Then it should finish successfully
    And the message should be a "Pio::OpenFlow10::PacketIn"

  Scenario: PortStatus
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    When I try to parse a file named "open_flow10/port_status.raw" with "OpenFlow" class
    Then it should finish successfully
    And the message should be a "Pio::OpenFlow10::PortStatus"

