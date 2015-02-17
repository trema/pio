require 'pio/features'

describe Pio::Features::Reply do
  context 'with a Features Reply message' do
    When(:result) { Pio::Features::Reply.read(binary) }

    describe '.read' do
      Given(:binary) do
        [0x01, 0x06, 0x00, 0xb0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00,
         0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x00, 0x00,
         0x0f, 0xff, 0x00, 0x02, 0x16, 0x7d, 0xa4, 0x37, 0xba, 0x10,
         0x74, 0x72, 0x65, 0x6d, 0x61, 0x30, 0x2d, 0x30, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0xff, 0xfe, 0x2a, 0xb4, 0xd6, 0x3c, 0x66, 0xba, 0x76, 0x73,
         0x77, 0x5f, 0x30, 0x78, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
         0x00, 0x01, 0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
         0x62, 0x94, 0x3a, 0xf6, 0x40, 0xdb, 0x74, 0x72, 0x65, 0x6d,
         0x61, 0x31, 0x2d, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00].pack('C*')
      end

      Then { result.class == Pio::Features::Reply }
      Then { result.ofp_version == 1 }
      Then do
        result.message_type ==
          Pio::OpenFlow::FEATURES_REPLY
      end
      Then { result.message_length == 176 }
      Then { result.transaction_id == 2 }
      Then { result.xid == 2 }
      Then { !result.body.empty? }
      Then { result.datapath_id == 1 }
      Then { result.n_buffers == 0x100 }
      Then { result.n_tables == 1 }
      Then do
        result.capabilities ==
          [:flow_stats, :table_stats, :port_stats, :arp_match_ip]
      end
      Then do
        result.actions ==
          [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan,
           :set_dl_src, :set_dl_dst, :set_nw_src, :set_nw_dst,
           :set_nw_tos, :set_tp_src, :set_tp_dst, :enqueue]
      end
      Then { result.ports.size == 3 }
      Then { result.ports.all? { |each| each.port_no > 0 } }
      Then do
        result.ports.all? do |each|
          /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i=~
            each.hardware_address.to_s
        end
      end
      Then { result.ports.all? { |each| !each.name.empty? } }
      Then { result.ports.any? { |each| each.config == [:port_down] } }
      Then { result.ports.any? { |each| each.state == [:link_down] } }
      Then { result.ports.all? { |each| each.curr.include? :port_copper } }
      Then { result.ports.all? { |each| each.advertised.empty? } }
      Then { result.ports.all? { |each| each.supported.empty? } }
      Then { result.ports.all? { |each| each.peer.empty? } }
    end

    context 'with a Hello message' do
      Given(:binary) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:result) { Pio::Features::Reply.read(binary) }

      Then do
        result == Failure(Pio::ParseError,
                          'Invalid Features Reply message.')
      end
    end
  end

  Given(:options) do
    {
      dpid: 0x123,
      n_buffers: 0x100,
      n_tables: 0xfe,
      capabilities: [:flow_stats, :table_stats, :port_stats, :queue_stats,
                     :arp_match_ip],
      actions: [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan,
                :set_dl_src, :set_dl_dst, :set_nw_src, :set_nw_dst,
                :set_nw_tos, :set_tp_src, :set_tp_dst, :enqueue],
      ports: [{ port_no: 1,
                hardware_address: '11:22:33:44:55:66',
                name: 'port123',
                config: [:port_down],
                state: [:link_down],
                curr: [:port_10gb_fd, :port_copper] }]
    }
  end

  describe '.new' do
    When(:features_reply) { Pio::Features::Reply.new(options) }

    Then { features_reply.ofp_version == 1 }
    Then { features_reply.message_type == Pio::OpenFlow::FEATURES_REPLY }
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
    Then { features_reply.ports.length == 1 }
    Then { features_reply.ports[0].port_no == 1 }
    Then { features_reply.ports[0].hardware_address == '11:22:33:44:55:66' }
    Then { features_reply.ports[0].name == 'port123' }
    Then { features_reply.ports[0].config == [:port_down] }
    Then { features_reply.ports[0].state == [:link_down] }
    Then { features_reply.ports[0].curr == [:port_10gb_fd, :port_copper] }
    Then { features_reply.ports[0].advertised.empty? }
    Then { features_reply.ports[0].supported.empty? }
    Then { features_reply.ports[0].peer.empty? }

    describe '#to_binary' do
      When(:result) { Pio::Features::Reply.new(options).to_binary }

      Then { result.length > 0 }
    end
  end
end
