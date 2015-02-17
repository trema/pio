require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.0 Port Status message
  class PortStatus
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

    # Message body of Port Status
    class Body < BinData::Record
      endian :big

      reason :reason
      uint56 :padding
      hide :padding
      phy_port :desc
    end
  end

  OpenFlow::Message.factory(PortStatus, OpenFlow::PORT_STATUS) do
    def_delegators :body, :desc

    def reason
      body.reason.to_s.to_sym
    end
  end
end
