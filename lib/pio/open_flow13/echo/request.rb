require 'pio/open_flow/message'

module Pio
  module OpenFlow13
    module Echo
      # OpenFlow 1.3 Echo Request message.
      class Request < OpenFlow::Message
        open_flow_header version: 4, message_type: 2
        string :body, read_length: -> { message_length - 8 }

        alias_method :user_data, :body
      end
    end
  end
end
