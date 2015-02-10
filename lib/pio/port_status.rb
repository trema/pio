require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Port Status message
  class PortStatus < OpenFlow::Message.factory(OpenFlow::Type::PORT_STATUS)
    # What changed about the physical port
    class Reason < BinData::Primitive
      REASONS = { add: 0, delete: 1, modify: 2 }

      uint8 :reason

      def get
        REASONS.invert.fetch(reason)
      end

      def set(value)
        self.reason = REASONS.fetch(value)
      end
    end

    # Message body of Packet-In.
    class PortStatusBody < BinData::Record
      endian :big

      reason :reason
      uint56 :padding
      hide :padding
      phy_port :desc
    end

    def_delegators :body, :desc

    def reason
      body.reason.to_s.to_sym
    end
  end
end
