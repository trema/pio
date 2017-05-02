# frozen_string_literal: true

require 'pio/open_flow/message'

module Pio
  module OpenFlow13
    module Echo
      # OpenFlow 1.3 Echo Reply message.
      class Reply < OpenFlow::Message
        open_flow_header version: 4, type: 3
        string :body, read_length: -> { length - 8 }

        alias user_data body
      end
    end
  end
end
