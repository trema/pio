require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # Features Request and Reply message.
    class Features
      # Features Request message.
      class Request < OpenFlow::Message
        open_flow_header version: 1, message_type: 5
        string :body, length: 0

        alias_method :user_data, :body
      end
    end
  end
end
