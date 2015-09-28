require 'pio/open_flow'

module Pio
  module OpenFlow10
    # Features Request and Reply message.
    class Features
      # Features Request message.
      class Request < OpenFlow::Message
        # Features Request message format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 5
          string :body, value: ''

          def user_data
            body
          end
        end
      end
    end
  end
end
