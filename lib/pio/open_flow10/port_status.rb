require 'pio/open_flow'

# Base module.
module Pio
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

    # Message body of Port Status
    class Body < BinData::Record
      endian :big

      reason :reason
      uint56 :padding
      hide :padding
      phy_port :desc
    end

    # OpenFlow 1.0 Flow Mod message format.
    class Format < BinData::Record
      extend OpenFlow::Format

      header version: 1, message_type: OpenFlow::PORT_STATUS
      body :body
    end

    attr_writer :datapath_id

    def desc
      @desc ||= @format.body.desc.snapshot
      @desc.instance_variable_set :@datapath_id, @datapath_id
      @desc
    end

    # rubocop:disable MethodLength
    def initialize(user_options = {})
      header_options = OpenFlowHeader::Options.parse(user_options)
      body_options = if user_options.respond_to?(:fetch)
                       user_options.delete :transaction_id
                       user_options.delete :xid
                       dpid = user_options[:dpid]
                       user_options[:datapath_id] = dpid if dpid
                       user_options
                     else
                       ''
                     end
      @format = Format.new(header: header_options, body: body_options)
    end
    # rubocop:enable MethodLength
  end
end
