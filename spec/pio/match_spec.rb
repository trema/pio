require 'pio/match'

describe Pio::Match do
  describe '.read' do
    Given(:dump) do
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

    When(:match) { Pio::Match.read(dump) }

    Then do
      match.wildcards == [
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

  describe '.new' do
    Given(:wildcards) do
      [
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
    When(:match) do
      Pio::Match.new(wildcards: wildcards,
                     in_port: 1,
                     dl_src: '00:00:00:00:00:00',
                     dl_dst: '00:00:00:00:00:00',
                     dl_vlan: 0,
                     dl_vlan_pcp: 0,
                     dl_type: 0,
                     dl_tos: 0,
                     nw_proto: 0,
                     nw_src: '0.0.0.0',
                     nw_dst: '0.0.0.0',
                     tp_src: 0,
                     tp_dst: 0
      )
    end

    Then do
      match.wildcards == [
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
end
