require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Barrier messages
    module Barrier
      # OpenFlow 1.0 Barrier Request message
      class Reply < OpenFlow::Message
        open_flow_header version: 1, message_type: 19
        string :body, value: ''
      end
    end
  end
end
