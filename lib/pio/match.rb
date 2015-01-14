require 'English'
require 'bindata'
require 'pio/open_flow'
require 'pio/type/ip_address'
require 'pio/type/mac_address'

module Pio
  # Fields to match against flows
  class Match < BinData::Record
    # Flow wildcards
    class Wildcards < BinData::Primitive
      BITS = {
        in_port: 1 << 0,
        dl_vlan: 1 << 1,
        dl_src: 1 << 2,
        dl_dst: 1 << 3,
        dl_type: 1 << 4,
        nw_proto: 1 << 5,
        tp_src: 1 << 6,
        tp_dst: 1 << 7,
        nw_src: 0,
        nw_src0: 1 << 8,
        nw_src1: 1 << 9,
        nw_src2: 1 << 10,
        nw_src3: 1 << 11,
        nw_src4: 1 << 12,
        nw_src_all: 1 << 13,
        nw_dst: 0,
        nw_dst0: 1 << 14,
        nw_dst1: 1 << 15,
        nw_dst2: 1 << 16,
        nw_dst3: 1 << 17,
        nw_dst4: 1 << 18,
        nw_dst_all: 1 << 19,
        dl_vlan_pcp: 1 << 20,
        nw_tos: 1 << 21
      }

      endian :big

      uint32 :flags

      def get
        BITS.each_with_object(Hash.new(0)) do |(key, bit), tmp|
          if flags & bit != 0
            if /(nw_src|nw_dst)(\d)/=~ key
              tmp[$LAST_MATCH_INFO[1].intern] |= (1 << $LAST_MATCH_INFO[2].to_i)
            else
              tmp[key] = true
            end
          end
          tmp
        end
      end

      # rubocop:disable MethodLength
      # rubocop:disable AbcSize
      def set(value)
        value[:nw_src0] = value[:nw_src] & 1
        value[:nw_src1] = value[:nw_src] & 2
        value[:nw_src2] = value[:nw_src] & 4
        value[:nw_src3] = value[:nw_src] & 8
        value[:nw_src4] = value[:nw_src] & 16

        value[:nw_dst0] = value[:nw_dst] & 1
        value[:nw_dst1] = value[:nw_dst] & 2
        value[:nw_dst2] = value[:nw_dst] & 4
        value[:nw_dst3] = value[:nw_dst] & 8
        value[:nw_dst4] = value[:nw_dst] & 16

        self.flags = value.keep_if { |_k, v| v && v != 0 }.keys.map do |each|
          BITS.fetch(each)
        end.inject(:|) || 0
      end
      # rubocop:enable MethodLength
      # rubocop:enable AbcSize
    end

    endian :big

    wildcards :wildcards, initial_value: -> { init_wildcards }
    uint16 :in_port
    mac_address :dl_src
    mac_address :dl_dst
    uint16 :dl_vlan
    uint8 :dl_vlan_pcp
    uint8 :padding1
    hide :padding1
    uint16 :dl_type
    uint8 :nw_tos
    uint8 :nw_proto
    uint16 :padding2
    hide :padding2
    ip_address :nw_src
    ip_address :nw_dst
    uint16 :tp_src
    uint16 :tp_dst

    private

    # rubocop:disable AbcSize
    # rubocop:disable MethodLength
    def init_wildcards
      {}.tap do |hash|
        hash[:in_port] = in_port == 0
        hash[:dl_vlan] = dl_vlan == 0
        hash[:dl_src] = dl_src == '00:00:00:00:00:00'
        hash[:dl_dst] = dl_dst == '00:00:00:00:00:00'
        hash[:dl_type] = dl_type == 0
        hash[:nw_proto] = nw_proto == 0
        hash[:tp_src] = tp_src == 0
        hash[:tp_dst] = tp_dst == 0
        hash[:nw_src] = nw_src.match_nw
        hash[:nw_src_all] = nw_src == '0.0.0.0'
        hash[:nw_dst] = nw_dst.match_nw
        hash[:nw_dst_all] = nw_dst == '0.0.0.0'
        hash[:dl_vlan_pcp] = dl_vlan_pcp == 0
        hash[:nw_tos] = nw_tos == 0
        hash.keep_if { |_k, v| v }
      end
    end
    # rubocop:enable AbcSize
    # rubocop:enable MethodLength
  end
end
