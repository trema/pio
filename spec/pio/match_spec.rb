require 'pio/match'

describe Pio::Match do
  describe '.read' do
    When(:match) { Pio::Match.read(binary) }

    context 'with a Match binary' do
      Given(:binary) do
        [
          0x00, 0x38, 0x20, 0xfe,
          0x00, 0x01,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00,
          0x00,
          0x00,
          0x00, 0x00,
          0x00,
          0x00,
          0x00, 0x00,
          0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00,
          0x00, 0x00,
          0x00, 0x00
        ].pack('C*')
      end

      Then do
        match.wildcards.keys == [
          :dl_vlan,
          :dl_src,
          :dl_dst,
          :dl_type,
          :nw_proto,
          :tp_src,
          :tp_dst,
          :nw_src_all,
          :nw_dst_all,
          :dl_vlan_pcp,
          :nw_tos
        ]
      end
      Then { match.in_port == 1 }
      Then { match.dl_src == '00:00:00:00:00:00' }
      Then { match.dl_dst == '00:00:00:00:00:00' }
      Then { match.dl_vlan == 0 }
      Then { match.dl_vlan_pcp == 0 }
      Then { match.dl_type == 0 }
      Then { match.nw_tos == 0 }
      Then { match.nw_proto == 0 }
      Then { match.nw_src == '0.0.0.0' }
      Then { match.nw_dst == '0.0.0.0' }
      Then { match.tp_src == 0 }
      Then { match.tp_dst == 0 }
    end

    context 'with a Match binary generated with Pio::Match.new' do
      Given(:binary) { Pio::Match.new(nw_src: '192.168.1.0/24').to_binary_s }

      Then do
        match.wildcards.keys == [
          :in_port,
          :dl_vlan,
          :dl_src,
          :dl_dst,
          :dl_type,
          :nw_proto,
          :tp_src,
          :tp_dst,
          :nw_src,
          :nw_dst_all,
          :dl_vlan_pcp,
          :nw_tos
        ]
      end
      And { match.wildcards[:nw_src] = 12 }
      Then { match.in_port == 0 }
      Then { match.dl_src == '00:00:00:00:00:00' }
      Then { match.dl_dst == '00:00:00:00:00:00' }
      Then { match.dl_vlan == 0 }
      Then { match.dl_vlan_pcp == 0 }
      Then { match.dl_type == 0 }
      Then { match.nw_tos == 0 }
      Then { match.nw_proto == 0 }
      Then { match.nw_src == '192.168.1.0' }
      Then { match.nw_src.prefixlen == 24 }
      Then { match.nw_dst == '0.0.0.0' }
      Then { match.tp_src == 0 }
      Then { match.tp_dst == 0 }
    end
  end

  describe '.new' do
    When(:match) { Pio::Match.new(options) }

    context 'with in_port: 1' do
      Given(:options) { { in_port: 1 } }
      Then do
        match.wildcards.keys == [
          :dl_vlan,
          :dl_src,
          :dl_dst,
          :dl_type,
          :nw_proto,
          :tp_src,
          :tp_dst,
          :nw_src_all,
          :nw_dst_all,
          :dl_vlan_pcp,
          :nw_tos
        ]
      end
      Then { match.in_port == 1 }
      Then { match.dl_src == '00:00:00:00:00:00' }
      Then { match.dl_dst == '00:00:00:00:00:00' }
      Then { match.dl_vlan == 0 }
      Then { match.dl_vlan_pcp == 0 }
      Then { match.dl_type == 0 }
      Then { match.nw_tos == 0 }
      Then { match.nw_proto == 0 }
      Then { match.nw_src == '0.0.0.0' }
      Then { match.nw_dst == '0.0.0.0' }
      Then { match.tp_src == 0 }
      Then { match.tp_dst == 0 }

      describe '#==' do
        When(:result) { match == other }

        context 'with Match.new(in_port: 1)' do
          Given(:other) { Pio::Match.new(in_port: 1) }
          Then { result == true }
        end
      end
    end

    context "with nw_src: '192.168.1.0/24'" do
      Given(:options) { { nw_src: '192.168.1.0/24' } }
      Then do
        match.wildcards.keys == [
          :in_port,
          :dl_vlan,
          :dl_src,
          :dl_dst,
          :dl_type,
          :nw_proto,
          :tp_src,
          :tp_dst,
          :nw_src,
          :nw_dst_all,
          :dl_vlan_pcp,
          :nw_tos
        ]
      end
      Then { match.wildcards.fetch(:nw_src) == 8 }
      Then { match.in_port == 0 }
      Then { match.dl_src == '00:00:00:00:00:00' }
      Then { match.dl_dst == '00:00:00:00:00:00' }
      Then { match.dl_vlan == 0 }
      Then { match.dl_vlan_pcp == 0 }
      Then { match.dl_type == 0 }
      Then { match.nw_tos == 0 }
      Then { match.nw_proto == 0 }
      Then { match.nw_src == '192.168.1.0/24' }
      Then { match.nw_dst == '0.0.0.0' }
      Then { match.tp_src == 0 }
      Then { match.tp_dst == 0 }
    end

    context "with nw_dst: '192.168.1.0/24'" do
      Given(:options) { { nw_dst: '192.168.1.0/24' } }
      Then do
        match.wildcards.keys == [
          :in_port,
          :dl_vlan,
          :dl_src,
          :dl_dst,
          :dl_type,
          :nw_proto,
          :tp_src,
          :tp_dst,
          :nw_src_all,
          :nw_dst,
          :dl_vlan_pcp,
          :nw_tos
        ]
      end
      Then { match.wildcards.fetch(:nw_dst) == 8 }
      Then { match.in_port == 0 }
      Then { match.dl_src == '00:00:00:00:00:00' }
      Then { match.dl_dst == '00:00:00:00:00:00' }
      Then { match.dl_vlan == 0 }
      Then { match.dl_vlan_pcp == 0 }
      Then { match.dl_type == 0 }
      Then { match.nw_tos == 0 }
      Then { match.nw_proto == 0 }
      Then { match.nw_src == '0.0.0.0' }
      Then { match.nw_dst == '192.168.1.0/24' }
      Then { match.tp_src == 0 }
      Then { match.tp_dst == 0 }
    end
  end
end
