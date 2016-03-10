module Pio
  module OpenFlow10
    class PacketIn < OpenFlow::Message
      # Why is this packet being sent to the controller?
      # (enum ofp_packet_in_reason)
      class Reason < BinData::Primitive
        REASONS = { no_match: 0, action: 1 }.freeze

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
