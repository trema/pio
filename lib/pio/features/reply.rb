require 'bindata'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Reply message
    class Reply < Pio::OpenFlow::Message
      # enum ofp_capabilities
      class Capabilities < BinData::Primitive
        extend Flags

        endian :big

        flags :capabilities,
              flow_stats: 1 << 0,
              table_stats: 1 << 1,
              port_stats: 1 << 2,
              stp: 1 << 3,
              reserved: 1 << 4,
              ip_reasm: 1 << 5,
              queue_stats: 1 << 6,
              arp_match_ip: 1 << 7
      end

      # enum ofp_action_type
      class Actions < BinData::Primitive
        extend Flags

        endian :big

        flags :actions,
              output: 1 << 0,
              set_vlan_vid: 1 << 1,
              set_vlan_pcp: 1 << 2,
              strip_vlan: 1 << 3,
              set_dl_src: 1 << 4,
              set_dl_dst: 1 << 5,
              set_nw_src: 1 << 6,
              set_nw_dst: 1 << 7,
              set_nw_tos: 1 << 8,
              set_tp_src: 1 << 9,
              set_tp_dst: 1 << 10,
              enqueue: 1 << 11
      end

      # Message body of features reply.
      class Body < BinData::Record
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
      end

      # OpenFlow 1.0 Features request message.
      class Format < BinData::Record
        include Pio::OpenFlow::Type

        endian :big

        open_flow_header :open_flow_header, message_type_value: FEATURES_REPLY
        virtual assert: -> { open_flow_header.message_type == FEATURES_REPLY }

        body :body
      end

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
