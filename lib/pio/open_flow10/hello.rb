require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # Hello message
    class Hello < OpenFlow::Message
      open_flow_header version: 1, message_type: 0
      string :body, length: 0

      alias_method :user_data, :body
    end
  end
end
