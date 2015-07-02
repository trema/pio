module Pio
  # OpenFlow specific types.
  module OpenFlow
    # OFPT_* constants.
    HELLO = 0
    ECHO_REQUEST = 2
    ECHO_REPLY = 3
    FEATURES_REQUEST = 5
    FEATURES_REPLY = 6
    PACKET_IN = 10
    PORT_STATUS = 12
    PACKET_OUT = 13
    FLOW_MOD = 14
  end
end

require 'pio/open_flow/datapath_id'
require 'pio/open_flow/flags'
require 'pio/open_flow/open_flow_header'
require 'pio/open_flow/phy_port'
require 'pio/open_flow/port_number'
