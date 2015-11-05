require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # Queue Stats messages
    class QueueStats
      # Queue Stats Request message
      class Request < OpenFlow::Message
        open_flow_header version: 1,
                         message_type: 16,
                         message_length: 20

        stats_type :stats_type, value: -> { :queue }
        uint16 :flags
        port16 :port
        string :padding, length: 2
        hide :padding
        uint32 :queue_id
      end
    end
  end
end
