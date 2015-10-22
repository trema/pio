require 'pio/open_flow/message'
require 'pio/open_flow10/match10'
require 'pio/open_flow10/stats_type'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 FlowStats messages
    module FlowStats
      # OpenFlow 1.0 Flow Stats Request message
      class Request < OpenFlow::Message
        open_flow_header version: 1,
                         message_type: 16,
                         message_length: 56

        stats_type :stats_type, value: -> { :flow }
        uint16 :flags
        match10 :match
        uint8 :table_id, initial_value: 0xff
        string :padding, length: 1
        hide :padding
        port16 :out_port, initial_value: -> { :none }
      end
    end
  end
end
