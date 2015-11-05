require 'pio/open_flow10/stats_type'
require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Table Stats messages
    module TableStats
      # OpenFlow 1.0 Table Stats Request message
      class Request < OpenFlow::Message
        open_flow_header version: 1,
                         message_type: 16,
                         message_length: 12
        stats_type :stats_type, value: -> { :table }
        uint16 :flags
        string :body, value: ''
      end
    end
  end
end
