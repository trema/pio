require 'pio/open_flow/format'
require 'pio/open_flow/message'

module Pio
  # OpenFlow 1.0 messages
  module OpenFlow10
    # OpenFlow 1.0 Barrier messages
    module Barrier
      # OpenFlow 1.0 Barrier Request message
      class Reply < OpenFlow::Message
        # OpenFlow 1.0 Barrier Request message format
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 19
          string :body, value: ''
        end
      end
    end
  end
end
