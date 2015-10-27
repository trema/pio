require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # Port Stats messages
    class PortStats
      # Port Stats Request message
      class Request < OpenFlow::Message
        open_flow_header version: 1,
                         message_type: 16,
                         message_length: 20

        stats_type :stats_type, value: -> { :port }
        uint16 :flags
        port16 :port
        string :padding, length: 6
        hide :padding

        def initialize(port, user_options = {})
          super({ port: port }.merge user_options)
        end
      end
    end
  end
end
