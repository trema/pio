require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.3 messages
  module OpenFlow13
    # OpenFlow 1.3 Features Request and Reply message.
    class Features
      # OpenFlow 1.3 Features Request message.
      class Request < OpenFlow::Message
        # OpenFlow 1.3 Features Request message format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 4, message_type: 5
          string :body, value: ''

          def user_data
            body
          end
        end
      end
    end
  end
end
