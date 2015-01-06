require 'bindata'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Reply message
    class Reply < Pio::OpenFlow::Message
      # Message body of features reply.
      class Body < BinData::Record
        extend Flags

        # enum ofp_capabilities
        def_flags :capabilities,
                  [:flow_stats,
                   :table_stats,
                   :port_stats,
                   :stp,
                   :reserved,
                   :ip_reasm,
                   :queue_stats,
                   :arp_match_ip]

        # enum ofp_action_type
        def_flags :actions,
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
        actions :actions
        array :ports, type: :phy_port, read_until: :eof

        def empty?
          false
        end

        def length
          24 + ports.to_binary_s.length
        end
      end

      def_format Pio::OpenFlow::Type::FEATURES_REPLY

      def datapath_id
        @format.body.datapath_id
      end

      def_delegators :body, :datapath_id
      def_delegator :body, :datapath_id, :dpid
      def_delegators :body, :n_buffers
      def_delegators :body, :n_tables
      def_delegators :body, :capabilities
      def_delegators :body, :actions
      def_delegators :body, :ports

      # @reek This method smells of :reek:FeatureEnvy
      def initialize(user_options)
        body_options =
          {
            datapath_id: user_options[:dpid],
            n_buffers: user_options[:n_buffers],
            n_tables: user_options[:n_tables],
            capabilities: user_options[:capabilities],
            actions: user_options[:actions],
            ports: user_options[:ports]
          }
        @format = Format.new(user_options.merge(body: body_options))
      end
    end
  end
end
