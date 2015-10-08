require 'pio/open_flow10/match10'
require 'pio/open_flow10/port16'
require 'pio/open_flow10/stats_type'

# Base module.
module Pio
  # OpenFlow 1.0 messages
  module OpenFlow10
    # OpenFlow 1.0 Aggregate Stats messages
    module AggregateStats
      # OpenFlow 1.0 Aggregate Stats Request message
      class Request < OpenFlow::Message
        # Message body of Flow Stats Request.
        class Body < BinData::Record
          endian :big

          stats_type :stats_type, value: -> { :aggregate }
          uint16 :flags
          match10 :match
          uint8 :table_id, initial_value: 0xff
          string :padding, length: 1
          hide :padding
          port16 :out_port, initial_value: -> { :none }

          def length
            48
          end
        end

        # OpenFlow 1.0 Aggregate Stats Request message format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 16
          body :body
        end

        body_option :match
      end
    end
  end
end
