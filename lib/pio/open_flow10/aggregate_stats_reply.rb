require 'pio/open_flow10/stats_type'

# Base module.
module Pio
  # OpenFlow 1.0 messages
  module OpenFlow10
    # Aggregate Stats messages
    module AggregateStats
      # Aggregate Stats Reply message
      class Reply < OpenFlow::Message
        # Message body of Flow Stats Request.
        class Body < BinData::Record
          endian :big

          stats_type :stats_type, value: -> { :aggregate }
          uint16 :flags
          uint64 :packet_count
          uint64 :byte_count
          uint32 :flow_count
          string :padding, length: 4
          hide :padding

          def length
            24
          end
        end

        # Aggregate Stats Reply message format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 17
          body :body
        end
      end
    end
  end
end
