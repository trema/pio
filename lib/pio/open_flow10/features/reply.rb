require 'pio/open_flow'
require 'pio/open_flow10/phy_port16'
require 'pio/open_flow10/port16'

module Pio
  module OpenFlow10
    # Features Request and Reply message.
    class Features
      # OpenFlow 1.0 Features Reply message.
      class Reply < OpenFlow::Message
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
                     :set_source_mac_address,
                     :set_destination_mac_address,
                     :set_source_ip_address,
                     :set_destination_ip_address,
                     :set_tos,
                     :set_transport_source_port,
                     :set_transport_destination_port,
                     :enqueue]

        open_flow_header version: 1,
                         message_type: 6,
                         message_length: -> { 32 + ports.to_binary_s.length }

        datapath_id :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint24 :padding
        hide :padding
        capabilities :capabilities
        actions_flag :actions
        array :ports, type: :phy_port16, read_until: :eof

        def datapath_id
          @format.datapath_id.to_i
        end
        alias_method :dpid, :datapath_id

        def ports
          snapshot.ports.map do |each|
            each.instance_variable_set :@datapath_id, datapath_id
            each
          end
        end

        def physical_ports
          ports.select do |each|
            each.port_no <= OpenFlow10::Port16::MAX
          end
        end
      end
    end
  end
end
