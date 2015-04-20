require 'forwardable'
require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.3 Features Request and Reply message.
  class Features
    remove_const :Reply

    # OpenFlow 1.3 Features Reply message.
    class Reply < BinData::Record
      extend Forwardable
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
      open_flow_header(:open_flow_header,
                       ofp_version_value: 4, message_type_value: 6)
      uint64 :datapath_id
      uint32 :n_buffers
      uint8 :n_tables
      uint8 :auxiliary_id
      uint16 :padding
      hide :padding
      capabilities :capabilities
      uint32 :reserved

      def_delegators :open_flow_header, :ofp_version
      def_delegators :open_flow_header, :message_type
      def_delegators :open_flow_header, :message_length
      def_delegators :open_flow_header, :transaction_id
      def_delegator :open_flow_header, :transaction_id, :xid

      def dpid
        datapath_id
      end
    end
  end
end
