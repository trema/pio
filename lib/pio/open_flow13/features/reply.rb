require 'pio/open_flow/datapath_id'
require 'pio/open_flow/message'

module Pio
  module OpenFlow13
    # Features Request and Reply message.
    class Features
      # Features Reply message.
      class Reply < OpenFlow::Message
        open_flow_header version: 4, type: 6, length: 32
        datapath_id :datapath_id
        alias dpid datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint8 :auxiliary_id
        uint16 :padding
        hide :padding
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
        uint32 :reserved
      end
    end
  end
end
