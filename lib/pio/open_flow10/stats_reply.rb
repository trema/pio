module Pio
  module OpenFlow10
    class Stats
      # Stats reply parser.
      class Reply
        # Stats reply format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 17
          stats_type :stats_type
        end

        TYPES = {
          description: OpenFlow10::DescriptionStats::Reply,
          flow: OpenFlow10::FlowStats::Reply,
          aggregate: OpenFlow10::AggregateStats::Reply
        }

        def self.read(binary)
          TYPES.fetch(Format.read(binary).stats_type.to_sym).read(binary)
        rescue KeyError
          raise "Unknown stats type: #{stats_type}"
        end
      end
    end
  end
end
