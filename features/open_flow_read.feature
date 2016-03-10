Feature: OpenFlow.read
  Scenario: OpenFlow 1.0
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
      | open_flow10/port_stats_request.raw        | Pio::OpenFlow10::PortStats::Request        |
      | open_flow10/port_status.raw               | Pio::OpenFlow10::PortStatus                |
      | open_flow10/queue_stats_request.raw       | Pio::OpenFlow10::QueueStats::Request       |
      | open_flow10/table_stats_request.raw       | Pio::OpenFlow10::TableStats::Request       |

  Scenario: OpenFlow 1.3
    Given I switch the Pio::OpenFlow version to "OpenFlow13"
    Then the following each raw file should be parsed into its corresponding object using OpenFlow.read
      | raw file                                          | result object                       |
      | open_flow13/bad_request.raw                       | Pio::OpenFlow13::Error::BadRequest  |
      | open_flow13/echo_reply_body.raw                   | Pio::OpenFlow13::Echo::Reply        |
      | open_flow13/echo_reply_no_body.raw                | Pio::OpenFlow13::Echo::Reply        |
      | open_flow13/echo_request_body.raw                 | Pio::OpenFlow13::Echo::Request      |
      | open_flow13/echo_request_no_body.raw              | Pio::OpenFlow13::Echo::Request      |
      | open_flow13/features_reply.raw                    | Pio::OpenFlow13::Features::Reply    |
      | open_flow13/features_request.raw                  | Pio::OpenFlow13::Features::Request  |
      | open_flow13/flow_mod_add_apply_no_match.raw       | Pio::OpenFlow13::FlowMod            |
      | open_flow13/flow_mod_no_match_or_instructions.raw | Pio::OpenFlow13::FlowMod            |
      | open_flow13/hello_failed.raw                      | Pio::OpenFlow13::Error::HelloFailed |
      | open_flow13/hello_no_version_bitmap.raw           | Pio::OpenFlow13::Hello              |
      | open_flow13/hello_version_bitmap.raw              | Pio::OpenFlow13::Hello              |
      | open_flow13/packet_in.raw                         | Pio::OpenFlow13::PacketIn           |
      | open_flow13/packet_out.raw                        | Pio::OpenFlow13::PacketOut          |
