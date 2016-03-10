require 'pio/open_flow/message'
require 'pio/open_flow10/phy_port16'
require 'pio/open_flow10/port_status/reason'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Port Status message
    class PortStatus < OpenFlow::Message
      open_flow_header version: 1,
                       type: 12,
                       length: -> { header_length + 8 + PhyPort16.length }
      reason :reason
      uint56 :padding
      hide :padding
      phy_port16 :description

      def reason
        @format.reason.to_sym
      end

      attr_writer :datapath_id

      def description
        @description ||= @format.description.snapshot
        @description.instance_variable_set :@datapath_id, @datapath_id
        @description
      end
    end
  end
end
