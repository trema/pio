require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features Request and Reply message.
  class Features
    # OpenFlow 1.0 Features Request message.
    class Request; end
    OpenFlow::Message.factory(Request, OpenFlow::FEATURES_REQUEST)

    # OpenFlow 1.0 Features Reply message.
    class Reply
      # Message body of features reply.
      class Body < BinData::Record
        extend OpenFlow::Flags

        # enum ofp_capabilities
        flags_32bit :capabilities,
                    [:flow_stats,
                     :table_stats,
                     :port_stats,
                     :stp,
                     :reserved,
                     :ip_reasm,
                     :queue_stats,
                     :arp_match_ip]

        # enum ofp_action_type
        flags_32bit :actions_flag,
                    [:output,
                     :set_vlan_vid,
                     :set_vlan_pcp,
                     :strip_vlan,
                     :set_dl_src,
                     :set_dl_dst,
                     :set_nw_src,
                     :set_nw_dst,
                     :set_nw_tos,
                     :set_tp_src,
                     :set_tp_dst,
                     :enqueue]

        endian :big

        uint64 :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint24 :padding
        hide :padding
        capabilities :capabilities
        actions_flag :actions
        array :ports, type: :phy_port, read_until: :eof

        def empty?
          false
        end

        def length
          24 + ports.to_binary_s.length
        end
      end
    end

    OpenFlow::Message.factory(Reply, OpenFlow::FEATURES_REPLY) do
      def_delegators :body, :datapath_id
      def_delegator :body, :datapath_id, :dpid
      def_delegators :body, :n_buffers
      def_delegators :body, :n_tables
      def_delegators :body, :capabilities
      def_delegators :body, :actions

      def ports
        @format.snapshot.body.ports.map do |each|
          each.instance_variable_set :@datapath_id, datapath_id
          each
        end
      end

      def physical_ports
        ports.select do |each|
          each.port_no <= PortNumber::MAX
        end
      end
    end
  end
end
