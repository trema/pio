require 'pio/open_flow10/table_stats/request'
require 'pio/open_flow10/port_stats/request'
require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    class Stats
      # Stats request parser.
      class Request
        TYPES = {
          description: OpenFlow10::DescriptionStats::Request,
          flow: OpenFlow10::FlowStats::Request,
          aggregate: OpenFlow10::AggregateStats::Request,
          table: OpenFlow10::TableStats::Request,
          port: OpenFlow10::PortStats::Request
        }

        # Stats request format.
        class Format < OpenFlow::Message
          open_flow_header version: 1, message_type: 16, message_length: 10
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
