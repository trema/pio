# frozen_string_literal: true

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Port Status message
    class PortStatus < OpenFlow::Message
      # What changed about the physical port
      class Reason < BinData::Primitive
        REASONS = { add: 0, delete: 1, modify: 2 }.freeze

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
