module Pio
  module OpenFlow
    # OFPT_* constants.
    module Type
      HELLO = 0
      ECHO_REQUEST = 2
      ECHO_REPLY = 3
      FEATURES_REQUEST = 5
      FEATURES_REPLY = 6
      PACKET_IN = 10
      PACKET_OUT = 13
      FLOW_MOD = 14
    end
  end
end
