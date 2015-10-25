require 'pio/open_flow/message'
require 'pio/open_flow10/match10'

module Pio
  module OpenFlow10
    # Flow Removed message
    class FlowRemoved < OpenFlow::Message
      # Why was this flow removed?
      # (enum ofp_flow_removed_reason)
      class Reason < BinData::Primitive
        REASONS = { idle_timeout: 0, hard_timeout: 1, delete: 2 }

        uint8 :reason

        def get
          REASONS.invert.fetch(reason)
        end

        def set(value)
          self.reason = REASONS.fetch(value)
        end
      end

      open_flow_header version: 1, message_type: 11, message_length: 88
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
