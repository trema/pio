@open_flow10
Feature: PortStatus

  As physical ports are added, modified, and removed from the
  datapath, the controller needs to be informed with the PortStatus
  message.

  Scenario: read
    When I parse a file named "open_flow10/port_status.raw" with "PortStatus" class
    Then the message has the following fields and values:
      | field          | value                      |
      | transaction_id | 4                          |
      | xid            | 4                          |
      | reason         | :delete                    |
      | number         | 65533                      |
      | mac_address    | 01:02:03:04:05:06          |
      | name           | foo                        |
      | config         | [:no_flood]                |
      | state          | [:stp_forward, :stp_block] |
      | curr           | [:port_10mb_hd]            |
      | advertised     | [:port_1gb_fd]             |
      | supported      | [:port_autoneg]            |
      | peer           | [:port_pause_asym]         |
    
