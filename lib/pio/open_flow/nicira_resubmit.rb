require 'pio/open_flow/nicira_action'
require 'pio/open_flow10/port16'

module Pio
  # NXAST_RESUBMIT action
  class NiciraResubmit < OpenFlow::NiciraAction
    nicira_action_header action_type: 0xffff,
                         action_length: 16,
                         subtype: 1
    port16 :in_port
    string :padding, length: 4
    hide :padding

    def initialize(port_number)
      super(in_port: port_number)
    end
  end
end
