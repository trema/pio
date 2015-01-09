require 'bindata'
require 'pio/match'

describe Pio::Match::Wildcards do
  describe '.read' do
    When(:wildcards) { Pio::Match::Wildcards.read(dump) }

    context 'with all 0' do
      Given(:dump) do
        ['00000000000000000000000000000000'].pack('B*')
      end

      Then { wildcards == [] }
    end

    context 'with in_port:1' do
      Given(:dump) do
        ['00000000000000000000000000000001'].pack('B*')
      end

      Then { wildcards == [:in_port] }
    end

    context 'with nw_src:010101' do
      Given(:dump) do
        ['00000000000000000001010100000000'].pack('B*')
      end

      Then { wildcards == [{ nw_src: 0b10101 }] }
    end

    context 'with nw_src:100000' do
      Given(:dump) do
        ['00000000000000000010000000000000'].pack('B*')
      end

      Then { wildcards == [:nw_src_all] }
    end

    context 'with nw_dst:010101' do
      Given(:dump) do
        ['00000000000001010100000000000000'].pack('B*')
      end

      Then { wildcards == [{ nw_dst: 0b10101 }] }
    end

    context 'with nw_dst:100000' do
      Given(:dump) do
        ['00000000000010000000000000000000'].pack('B*')
      end

      Then { wildcards == [:nw_dst_all] }
    end

    context 'with in_port:1, nw_src:010101, nw_dst:010101, and nw_tos:1' do
      Given(:dump) do
        ['00000000001001010101010100000001'].pack('B*')
      end

      Then do
        wildcards ==
          [:in_port, { nw_src: 0b010101 }, { nw_dst: 0b010101 }, :nw_tos]
      end
    end
  end
end
