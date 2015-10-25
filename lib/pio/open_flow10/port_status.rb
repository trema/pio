require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Port Status message
    class PortStatus < OpenFlow::Message
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

      open_flow_header version: 1,
                       message_type: 12,
                       message_length: 10
      reason :reason
      uint56 :padding
      hide :padding
      phy_port16 :desc

      def reason
        @format.reason.to_sym
      end

      attr_writer :datapath_id

      def desc
        @desc ||= @format.desc.snapshot
        @desc.instance_variable_set :@datapath_id, @datapath_id
        @desc
      end
    end
  end
end
