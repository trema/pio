require 'pio/open_flow/nicira_action'
require 'pio/open_flow10/port16'

module Pio
  # NXAST_RESUBMIT_TABLE action
  class NiciraResubmitTable < OpenFlow::NiciraAction
    nicira_action_header action_type: 0xffff,
                         action_length: 16,
                         subtype: 14
    port16 :in_port
    uint8 :table, initial_value: 0xff
    string :padding, length: 3
    hide :padding
  end
end
