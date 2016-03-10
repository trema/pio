require 'pio/open_flow/message'
require 'pio/open_flow10/aggregate_stats/request'
require 'pio/open_flow10/flow_stats/request'
require 'pio/open_flow10/port_stats/request'
require 'pio/open_flow10/queue_stats/request'
require 'pio/open_flow10/table_stats/request'

module Pio
  module OpenFlow10
    class Stats
      # Stats request parser.
      class Request < OpenFlow::Message
        open_flow_header version: 1, type: 16, length: 10
        stats_type :stats_type

        TYPE = {
          aggregate: OpenFlow10::AggregateStats::Request,
          description: OpenFlow10::DescriptionStats::Request,
          flow: OpenFlow10::FlowStats::Request,
          port: OpenFlow10::PortStats::Request,
          queue: OpenFlow10::QueueStats::Request,
          table: OpenFlow10::TableStats::Request
        }.freeze

        def self.read(binary)
          TYPE.fetch(Format.read(binary).stats_type.to_sym).read(binary)
        rescue KeyError
          raise "Unknown stats type: #{stats_type}"
        end
      end
    end
  end
end
