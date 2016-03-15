require 'active_support/core_ext/module/delegation'
require 'pio/open_flow/message'
require 'pio/open_flow10/phy_port16'
require 'pio/open_flow10/port_status/reason'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Port Status message
    class PortStatus < OpenFlow::Message
      open_flow_header version: 1, type: 12,
                       length: -> { header_length + 8 + PhyPort16.length }

      reason :reason
      uint56 :padding
      hide :padding
      phy_port16 :description

      attr_accessor :datapath_id
      alias dpid datapath_id
      alias dpid= datapath_id=

      delegate :number, to: :description
      delegate :mac_address, to: :description
      delegate :name, to: :description
      delegate :config, to: :description
      delegate :state, to: :description
      delegate :curr, to: :description
      delegate :advertised, to: :description
      delegate :supported, to: :description
      delegate :peer, to: :description
      delegate :up?, to: :description
      delegate :down?, to: :description
      delegate :local?, to: :description
    end
  end
end
