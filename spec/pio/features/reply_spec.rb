require 'pio/features'

describe Pio::Features::Reply do
  describe '.new' do
    Given(:options) do
      {
        dpid: 0x123,
        n_buffers: 0x100,
        n_tables: 0xfe,
        capabilities: [:flow_stats, :table_stats, :port_stats, :queue_stats,
                       :arp_match_ip],
        actions: [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan,
                  :set_dl_src, :set_dl_dst, :set_nw_src, :set_nw_dst,
                  :set_nw_tos, :set_tp_src, :set_tp_dst, :enqueue]
      }
    end

    When(:features_reply) { Pio::Features::Reply.new(options) }

    Then { features_reply.ofp_version == 1 }
    Then { features_reply.message_type == Pio::OpenFlow::Type::FEATURES_REPLY }
    Then { features_reply.transaction_id == 0 }
    Then { features_reply.xid == 0 }
    Then { features_reply.dpid == 0x123 }
    Then { features_reply.n_buffers == 0x100 }
    Then { features_reply.n_tables == 0xfe }
    Then do
      features_reply.capabilities ==
        [:flow_stats, :table_stats, :port_stats, :queue_stats, :arp_match_ip]
    end
    Then do
      features_reply.actions ==
        [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan, :set_dl_src,
         :set_dl_dst, :set_nw_src, :set_nw_dst, :set_nw_tos, :set_tp_src,
         :set_tp_dst, :enqueue]
    end
    Then { features_reply.ports == [] }
  end
end
