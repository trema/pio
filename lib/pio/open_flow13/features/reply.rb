require 'pio/open_flow/datapath_id'
require 'pio/open_flow/flags'
require 'pio/open_flow/message'

module Pio
  module OpenFlow13
    # Features Request and Reply message.
    class Features
      # Features Reply message.
      class Reply < OpenFlow::Message
        extend OpenFlow::Flags

        flags_32bit(:capabilities,
                    [:flow_stats,
                     :table_stats,
                     :port_stats,
                     :group_stats,
                     :NOT_USED,
                     :ip_reasm,
                     :queue_stats,
                     :NOT_USED,
                     :port_blocked])

        open_flow_header version: 4, type: 6, length: 32
        datapath_id :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint8 :auxiliary_id
        uint16 :padding
        hide :padding
        capabilities :capabilities
        uint32 :reserved

        def datapath_id
          @format.datapath_id.to_i
        end
        alias dpid datapath_id
      end
    end
  end
end
