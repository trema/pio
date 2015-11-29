require 'pio/open_flow/message'
require 'pio/open_flow10/stats_type'

module Pio
  module OpenFlow10
    # Aggregate Stats messages
    module AggregateStats
      # Aggregate Stats Reply message
      class Reply < OpenFlow::Message
        open_flow_header version: 1, type: 17, length: 32
        stats_type :stats_type, value: -> { :aggregate }
        uint16 :flags
        uint64 :packet_count
        uint64 :byte_count
        uint32 :flow_count
        string :padding, length: 4
        hide :padding
      end
    end
  end
end
