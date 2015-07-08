require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.3 Features Request and Reply message.
  class Features
    remove_const :Reply if const_defined?(:Reply)

    # OpenFlow 1.3 Features Reply message.
    class Reply < OpenFlow::Message
      # OpenFlow 1.3 Features Reply message body.
      class Body < BinData::Record
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

        endian :big

        datapath_id :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint8 :auxiliary_id
        uint16 :padding
        hide :padding
        capabilities :capabilities
        uint32 :reserved

        def length
          24
        end
      end

      # OpenFlow 1.3 Features Reply message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 4, message_type: 6
        body :body

        def dpid
          datapath_id
        end
      end

      body_option :dpid
      body_option :datapath_id
      body_option :n_buffers
      body_option :n_tables
      body_option :capabilities
    end
  end
end
