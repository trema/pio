require 'pio/open_flow/message'
require 'pio/open_flow10/aggregate_stats/reply'
require 'pio/open_flow10/description_stats/reply'
require 'pio/open_flow10/flow_stats/reply'

module Pio
  module OpenFlow10
    class Stats
      # Stats reply parser.
      class Reply
        TYPES = {
          description: OpenFlow10::DescriptionStats::Reply,
          flow: OpenFlow10::FlowStats::Reply,
          aggregate: OpenFlow10::AggregateStats::Reply
        }

        # Stats reply format.
        class Format < OpenFlow::Message
          open_flow_header version: 1, message_type: 17, message_length: 10
          stats_type :stats_type
        end

        def self.read(binary)
          TYPES.fetch(Format.read(binary).stats_type.to_sym).read(binary)
        rescue KeyError
          raise "Unknown stats type: #{stats_type}"
        end
      end
    end
  end
end
