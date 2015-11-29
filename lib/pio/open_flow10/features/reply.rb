require 'pio/open_flow/datapath_id'
require 'pio/open_flow/message'
require 'pio/open_flow10/features/reply/actions_flag'
require 'pio/open_flow10/features/reply/capabilities'
require 'pio/open_flow10/phy_port16'
require 'pio/open_flow10/port16'

module Pio
  module OpenFlow10
    # Features Request and Reply message.
    class Features
      # OpenFlow 1.0 Features Reply message.
      class Reply < OpenFlow::Message
        open_flow_header(version: 1,
                         type: 6,
                         length: lambda do
                           header_length + 24 + PhyPort16.length * ports.length
                         end)

        datapath_id :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        string :padding, length: 3
        hide :padding
        capabilities :capabilities
        actions_flag :actions
        array :ports,
              type: :phy_port16,
              length: -> { length - header_length - 24 }

        def datapath_id
          format.datapath_id.to_i
        end
        alias dpid datapath_id

        def ports
          snapshot.ports.map do |each|
            each.instance_variable_set :@datapath_id, datapath_id
            each
          end
        end
      end
    end
  end
end
