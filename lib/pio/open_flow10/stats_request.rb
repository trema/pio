module Pio
  module OpenFlow10
    class Stats
      # Stats request parser.
      class Request
        # Stats request format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 16
          stats_type :stats_type
        end

        TYPES = {
          description: OpenFlow10::DescriptionStats::Request,
          flow: OpenFlow10::FlowStats::Request,
          aggregate: OpenFlow10::AggregateStats::Request
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
