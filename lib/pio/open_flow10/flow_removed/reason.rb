module Pio
  module OpenFlow10
    # Flow Removed message
    class FlowRemoved < OpenFlow::Message
      # Why was this flow removed?
      # (enum ofp_flow_removed_reason)
      class Reason < BinData::Primitive
        REASONS = { idle_timeout: 0, hard_timeout: 1, delete: 2 }.freeze

        uint8 :reason

        def get
          REASONS.invert.fetch(reason)
        end

        def set(value)
          self.reason = REASONS.fetch(value)
        end
      end
    end
  end
end
