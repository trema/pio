Feature: Pio::OpenFlow.version
  Scenario: OpenFlow 1.0
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    When I get the OpenFlow version string
    Then the version string should be "OpenFlow10"

  Scenario: OpenFlow 1.3
    Given I switch the Pio::OpenFlow version to "OpenFlow13"
    When I get the OpenFlow version string
    Then the version string should be "OpenFlow13"
