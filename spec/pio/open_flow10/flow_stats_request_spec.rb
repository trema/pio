require 'pio/open_flow10/flow_stats/request'

describe Pio::OpenFlow10::FlowStats::Request do
  describe '.read' do
    context 'with a Flow Stats Request binary' do
      Given(:binary) do
        [0x01, 0x10, 0x00, 0x38, 0x00, 0x00, 0x00, 0x0d, 0x00, 0x01,
         0x00, 0x00, 0x00, 0x38, 0x20, 0xff, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0xff, 0x00, 0xff, 0xff].pack('C*')
      end

      When(:flow_stats_request) do
        Pio::OpenFlow10::FlowStats::Request.read(binary)
      end

      Then { flow_stats_request.class == Pio::OpenFlow10::FlowStats::Request }
      Then { flow_stats_request.ofp_version == 1 }
      Then { flow_stats_request.message_type == 16 }
      Then { flow_stats_request.message_length == 56 }
      Then { flow_stats_request.transaction_id == 13 }
      Then { flow_stats_request.xid == 13 }
      Then { flow_stats_request.stats_type == :flow }
      Then do
        flow_stats_request.match.wildcards.keys.sort ==
          [:destination_mac_address, :source_mac_address,
           :ether_type, :in_port, :destination_ip_address_all,
           :ip_protocol, :source_ip_address_all, :tos,
           :transport_destination_port, :transport_source_port,
           :vlan_priority, :vlan_vid].sort
      end
      Then { flow_stats_request.table_id == 0xff }
      Then { flow_stats_request.out_port == :none }
    end
  end
end
