# encoding: utf-8

require 'bindata'
require 'pio/features/message'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Reply message
    class Reply < Pio::OpenFlow::Message
      # bitmap functions.
      module Flags
        def flags(name, flags)
          def_get name, flags
          def_set name, flags
        end

        def def_get(name, list)
          str = %{
            def get
              list = #{list.inspect}
              (0..(list.length - 1)).each_with_object([]) do |each, result|
                result << list[each] if #{name} & (1 << each) != 0
                result
              end
            end
          }
          module_eval str
        end

        def def_set(name, list)
          str = %{
            def set(v)
              list = #{list.inspect}
              v.each do |each|
                fail "Invalid #{name} flag: \#{v}" unless list.include?(each)
              end
              self.#{name} = v.map { |each| 1 << list.index(each) }.inject(:|)
            end
          }
          module_eval str
        end
      end

      # ofp_capabilities
      class Capabilities < BinData::Primitive
        extend Flags
        flags :capabilities,
              [:flow_stats, :table_stats, :port_stats, :stp, :reserved,
               :ip_reasm, :queue_stats, :arp_match_ip]

        endian :big
        uint32 :capabilities
      end

      # ofp_action_type
      class Actions < BinData::Primitive
        extend Flags
        flags :actions,
              [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan,
               :set_dl_src, :set_dl_dst, :set_nw_src, :set_nw_dst,
               :set_nw_tos, :set_tp_src, :set_tp_dst, :enqueue]

        endian :big
        uint32 :actions
      end

      # OpenFlow 1.0 Features request message.
      class Format < BinData::Record
        include Pio::OpenFlow::Type

        endian :big

        open_flow_header :open_flow_header, message_type_value: FEATURES_REPLY
        virtual assert: -> { open_flow_header.message_type == FEATURES_REPLY }

        struct :body do
          uint64 :datapath_id
          uint32 :n_buffers
          uint8 :n_tables
          uint24 :padding
          capabilities :capabilities
          actions :actions
          array :ports, type: :phy_port, read_until: :eof
        end
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
