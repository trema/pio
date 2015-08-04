Feature: Pio::OpenFlow.read
  Scenario: OpenFlow10
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    Then the following each raw file should be parsed into its corresponding object using OpenFlow.read
      | raw file                         | result object                      |
      | open_flow10/hello.raw            | Pio::OpenFlow10::Hello             |
      | open_flow10/echo_request.raw     | Pio::OpenFlow10::Echo::Request     |
      | open_flow10/echo_reply.raw       | Pio::OpenFlow10::Echo::Reply       |
      | open_flow10/features_request.raw | Pio::OpenFlow10::Features::Request |
      | open_flow10/features_reply.raw   | Pio::OpenFlow10::Features::Reply   |
      | open_flow10/packet_in.raw        | Pio::OpenFlow10::PacketIn          |
      | open_flow10/port_status.raw      | Pio::OpenFlow10::PortStatus        |
      | open_flow10/barrier_request.raw  | Pio::OpenFlow10::Barrier::Request  |
      | open_flow10/barrier_reply.raw    | Pio::OpenFlow10::Barrier::Reply    |
