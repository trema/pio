# frozen_string_literal: true

require 'pio/open_flow/datapath_id'
require 'pio/open_flow/message'
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
        alias dpid datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        string :padding, length: 3
        hide :padding
        flags_32bit :capabilities,
                    %i[flow_stats
                       table_stats
                       port_stats
                       stp
                       reserved
                       ip_reasm
                       queue_stats
                       arp_match_ip]
        flags_32bit :actions,
                    %i[output
                       set_vlan_vid
                       set_vlan_pcp
                       strip_vlan
                       set_source_mac_address
                       set_destination_mac_address
                       set_source_ip_address
                       set_destination_ip_address
                       set_tos
                       set_transport_source_port
                       set_transport_destination_port
                       enqueue]
        array :ports, type: :phy_port16, read_until: :eof

        def ports
          super.map do |each|
            each.datapath_id = datapath_id
            each
          end
        end
      end
    end
  end
end
