Feature: Pio::PortStatus
  Scenario: read
    When I try to parse a file named "open_flow10/port_status.raw" with "PortStatus" class
    Then it should finish successfully
    And the message has the following fields and values:
      | field                 | value                       |
      | class                 | Pio::OpenFlow10::PortStatus |
      | ofp_version           | 1                           |
      | message_type          | 12                          |
      | message_length        | 64                          |
      | transaction_id        | 4                           |
      | xid                   | 4                           |
      | reason                | :delete                     |
      | desc.port_no          | 65533                       |
      | desc.hardware_address | 01:02:03:04:05:06           |
      | desc.name             | foo                         |
      | desc.config           | [:no_flood]                 |
      | desc.state            | [:stp_forward, :stp_block]  |
      | desc.curr             | [:port_10mb_hd]             |
      | desc.advertised       | [:port_1gb_fd]              |
      | desc.supported        | [:port_autoneg]             |
      | desc.peer             | [:port_pause_asym]          |
    
