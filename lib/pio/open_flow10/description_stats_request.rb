require 'pio/open_flow10/stats_type'
require 'pio/open_flow/format'
require 'pio/open_flow/message'

# Base module.
module Pio
  # OpenFlow 1.0 messages
  module OpenFlow10
    # OpenFlow 1.0 Description Stats messages
    module DescriptionStats
      # OpenFlow 1.0 Description Stats Request message
      class Request < OpenFlow::Message
        # Message body of Flow Stats Request.
        class Body < BinData::Record
          endian :big

          stats_type :stats_type, value: -> { :description }
          uint16 :flags
          string :body, value: ''

          def length
            4
          end
        end

        # OpenFlow 1.0 Description Stats Request message format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 16
          body :body
        end
      end
    end
  end
end
