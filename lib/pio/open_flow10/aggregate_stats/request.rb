# frozen_string_literal: true

require 'pio/open_flow/message'
require 'pio/open_flow10/match10'
require 'pio/open_flow10/port16'
require 'pio/open_flow10/stats_type'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Aggregate Stats messages
    module AggregateStats
      # OpenFlow 1.0 Aggregate Stats Request message
      class Request < OpenFlow::Message
        open_flow_header version: 1, type: 16, length: 56
        stats_type :stats_type, value: -> { :aggregate }
        uint16 :flags
        match10 :match
        uint8 :table_id, initial_value: 0xff
        string :padding, length: 1
        hide :padding
        port16 :out_port, initial_value: -> { :none }
      end
    end
  end
end
