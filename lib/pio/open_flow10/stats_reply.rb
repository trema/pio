# frozen_string_literal: true

require 'pio/open_flow/message'
require 'pio/open_flow10/aggregate_stats/reply'
require 'pio/open_flow10/description_stats/reply'
require 'pio/open_flow10/flow_stats/reply'

module Pio
  module OpenFlow10
    class Stats
      # Stats reply parser.
      class Reply < OpenFlow::Message
        open_flow_header version: 1, type: 17, length: 10
        stats_type :stats_type

        TYPE = {
          description: OpenFlow10::DescriptionStats::Reply,
          flow: OpenFlow10::FlowStats::Reply,
          aggregate: OpenFlow10::AggregateStats::Reply
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
