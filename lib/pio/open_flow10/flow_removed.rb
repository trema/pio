# frozen_string_literal: true

require 'pio/open_flow/message'
require 'pio/open_flow10/match10'
require 'pio/open_flow10/flow_removed/reason'

module Pio
  module OpenFlow10
    # Flow Removed message
    class FlowRemoved < OpenFlow::Message
      open_flow_header version: 1, type: 11, length: 88
      match10 :match
      uint64 :cookie
      uint16 :priority
      reason :reason
      string :padding1, length: 1
      hide :padding1
      uint32 :duration_sec
      uint32 :duration_nsec
      uint16 :idle_timeout
      string :padding2, length: 2
      hide :padding2
      uint64 :packet_count
      uint64 :byte_count
    end
  end
end
