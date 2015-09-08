require 'pio/open_flow/format'
require 'pio/open_flow/message'

# Base module.
module Pio
  # OpenFlow 1.0 messages
  module OpenFlow10
    # Hello message
    class Hello < OpenFlow::Message
      # Hello message format
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: 0
        string :body

        def user_data
          body
        end
      end
    end
  end
end
