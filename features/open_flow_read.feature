Feature: Pio::OpenFlow.read
  Scenario: OpenFlow10
    Given I switch the Pio::OpenFlow version to "OpenFlow10"
    Then the following each raw file should be parsed into its corresponding object using OpenFlow.read
      | raw file                                  | result object                              |
      | open_flow10/aggregate_stats_reply.raw     | Pio::OpenFlow10::AggregateStats::Reply     |
      | open_flow10/aggregate_stats_request.raw   | Pio::OpenFlow10::AggregateStats::Request   |
      | open_flow10/bad_request.raw               | Pio::OpenFlow10::Error::BadRequest         |
      | open_flow10/barrier_reply.raw             | Pio::OpenFlow10::Barrier::Reply            |
      | open_flow10/barrier_request.raw           | Pio::OpenFlow10::Barrier::Request          |
      | open_flow10/description_stats_reply.raw   | Pio::OpenFlow10::DescriptionStats::Reply   |
      | open_flow10/description_stats_request.raw | Pio::OpenFlow10::DescriptionStats::Request |
      | open_flow10/echo_reply.raw                | Pio::OpenFlow10::Echo::Reply               |
      | open_flow10/echo_request.raw              | Pio::OpenFlow10::Echo::Request             |
      | open_flow10/features_reply.raw            | Pio::OpenFlow10::Features::Reply           |
      | open_flow10/features_request.raw          | Pio::OpenFlow10::Features::Request         |
      | open_flow10/flow_mod_add.raw              | Pio::OpenFlow10::FlowMod                   |
      | open_flow10/flow_stats_reply.raw          | Pio::OpenFlow10::FlowStats::Reply          |
      | open_flow10/flow_stats_request.raw        | Pio::OpenFlow10::FlowStats::Request        |
      | open_flow10/hello.raw                     | Pio::OpenFlow10::Hello                     |
      | open_flow10/hello_failed.raw              | Pio::OpenFlow10::Error::HelloFailed        |
      | open_flow10/packet_in.raw                 | Pio::OpenFlow10::PacketIn                  |
      | open_flow10/packet_out.raw                | Pio::OpenFlow10::PacketOut                 |
      | open_flow10/port_status.raw               | Pio::OpenFlow10::PortStatus                |
      | open_flow13/bad_request.raw               | Pio::OpenFlow13::Error::BadRequest         |
      | open_flow13/hello_failed.raw              | Pio::OpenFlow13::Error::HelloFailed        |
