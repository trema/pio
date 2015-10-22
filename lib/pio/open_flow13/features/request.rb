require 'pio/open_flow/message'

module Pio
  module OpenFlow13
    # Features Request and Reply message.
    class Features
      # Features Request message.
      class Request < OpenFlow::Message
        open_flow_header version: 4, message_type: 5
        string :body, value: ''
      end
    end
  end
end
