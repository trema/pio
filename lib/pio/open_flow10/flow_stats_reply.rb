require 'pio/open_flow10/actions'
require 'pio/open_flow10/stats_type'

# Base module.
module Pio
  # OpenFlow 1.0 messages
  module OpenFlow10
    # OpenFlow 1.0 FlowStats messages
    module FlowStats
      # OpenFlow 1.0 Flow Stats Reply message
      class Reply < OpenFlow::Message
        # Body of reply to Flow Stats Request.
        class FlowStatsEntry < BinData::Record
          endian :big

          uint16 :entry_length
          uint8 :table_id
          string :padding1, length: 1
          hide :padding1
          match_open_flow10 :match
          uint32 :duration_sec
          uint32 :duration_nsec
          uint16 :priority
          uint16 :idle_timeout
          uint16 :hard_timeout
          string :padding2, length: 6
          hide :padding2
          uint64 :cookie
          uint64 :packet_count
          uint64 :byte_count
          actions :actions, length: -> { entry_length - 88 }
        end

        # Message body of Flow Stats Reply.
        class Body < BinData::Record
          endian :big

          stats_type :stats_type, value: -> { :flow }
          uint16 :flags
          array(:stats,
                type: :flow_stats_entry,
                read_until: :eof)

          def length
            4 + stats.to_binary_s.length
          end
        end

        # OpenFlow 1.0 Flow Stats Reply message format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 17
          body :body
        end
      end
    end
  end
end
