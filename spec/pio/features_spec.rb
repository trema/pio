require 'pio/features'

describe Pio::Features do
  describe '.read' do
    context 'with a Features Request message' do
      Given(:request_dump) { [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:request) { Pio::Features.read(request_dump) }

      Then { request.class == Pio::Features::Request }
      Then { request.ofp_version == 1 }
      Then do
        request.message_type ==
          Pio::OpenFlow::Type::FEATURES_REQUEST
      end
      Then { request.message_length == 8 }
      Then { request.transaction_id == 0 }
      Then { request.xid == 0 }
      Then { request.body.empty? }
    end

    context 'with a Features Reply message' do
      Given(:reply_dump) do
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

      When(:reply) { Pio::Features.read(reply_dump) }

      Then { reply.class == Pio::Features::Reply }
      Then { reply.ofp_version == 1 }
      Then do
        reply.message_type ==
          Pio::OpenFlow::Type::FEATURES_REPLY
      end
      Then { reply.message_length == 176 }
      Then { reply.transaction_id == 2 }
      Then { reply.xid == 2 }
      Then do
        pending 'TODO'
        !reply.body.empty?
      end
      Then { reply.datapath_id == 1 }
      Then { reply.n_buffers == 0x100 }
      Then { reply.n_tables == 1 }
      Then do
        reply.capabilities ==
          [:flow_stats, :table_stats, :port_stats, :arp_match_ip]
      end
      Then do
        reply.actions ==
          [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan,
           :set_dl_src, :set_dl_dst, :set_nw_src, :set_nw_dst,
           :set_nw_tos, :set_tp_src, :set_tp_dst, :enqueue]
      end
      Then { reply.ports.size == 3 }
      Then { reply.ports.all? { |each| each.port_no > 0 } }
      Then do
        reply.ports.all? do |each|
          /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i=~
            each.hardware_address.to_s
        end
      end
      Then { reply.ports.all? { |each| !each.name.empty? } }
      Then { reply.ports.any? { |each| each.config == [:port_down] } }
      Then { reply.ports.any? { |each| each.state == [:link_down] } }
      Then { reply.ports.all? { |each| each.curr.include? :port_copper } }
      Then { reply.ports.all? { |each| each.advertised.empty? } }
      Then { reply.ports.all? { |each| each.supported.empty? } }
      Then { reply.ports.all? { |each| each.peer.empty? } }
    end

    context 'with a Hello message' do
      Given(:hello_dump) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:result) { Pio::Features.read(hello_dump) }

      Then do
        result == Failure(Pio::ParseError,
                          'Invalid features request/reply message.')
      end
    end
  end
end
