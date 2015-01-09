require 'bindata'
require 'pio/open_flow'
require 'pio/type/ip_address'
require 'pio/type/mac_address'

module Pio
  # Fields to match against flows
  class Match < BinData::Record
    # Flow wildcards
    class Wildcards < BinData::Primitive
      FLAGS = {
        in_port: 1 << 0,
        dl_vlan: 1 << 1,
        dl_src: 1 << 2,
        dl_dst: 1 << 3,
        dl_type: 1 << 4,
        nw_proto: 1 << 5,
        tp_src: 1 << 6,
        tp_dst: 1 << 7,
        nw_src0: 1 << 8,
        nw_src1: 1 << 9,
        nw_src2: 1 << 10,
        nw_src3: 1 << 11,
        nw_src4: 1 << 12,
        nw_src_all: 1 << 13,
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

      # rubocop:disable AbcSize
      # rubocop:disable CyclomaticComplexity
      # rubocop:disable MethodLength
      def get
        nw_src = 0
        nw_dst = 0
        FLAGS.each_with_object([]) do |(key, value), result|
          if flags & value != 0
            case key
            when /nw_src(\d)/
              bit = Regexp.last_match[1].to_i
              nw_src += 1 << bit
              result << { nw_src: nw_src } if bit == 4 && nw_src > 0
            when /nw_dst(\d)/
              bit = Regexp.last_match[1].to_i
              nw_dst += 1 << bit
              result << { nw_dst: nw_dst } if bit == 4 && nw_dst > 0
            else
              result << key
            end
          end
          result
        end
      end
      # rubocop:enable MethodLength
      # rubocop:enable CyclomaticComplexity
      # rubocop:enable AbcSize

      def set(value)
        value.each do |each|
          fail "Invalid flag: #{each}" unless FLAGS.keys.include?(each)
        end
        self.flags =
          value.empty? ? 0 : value.map { |each| FLAGS[each] }.inject(:|)
      end
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
    # rubocop:disable CyclomaticComplexity
    # rubocop:disable PerceivedComplexity
    # rubocop:disable MethodLength
    def init_wildcards
      result = []
      result << :in_port if in_port == 0
      result << :dl_vlan if dl_vlan == 0
      result << :dl_src if dl_src == '00:00:00:00:00:00'
      result << :dl_dst if dl_dst == '00:00:00:00:00:00'
      result << :dl_type if dl_type == 0
      result << :nw_proto if nw_proto == 0
      result << :tp_src if tp_src == 0
      result << :tp_dst if tp_dst == 0
      result << { nw_src: nw_src.match_nw } if nw_src.match_nw
      result << :nw_src_all if nw_src == '0.0.0.0'
      result << { nw_dst: nw_dst.match_nw } if nw_dst.match_nw
      result << :nw_dst_all if nw_dst == '0.0.0.0'
      result << :dl_vlan_pcp if dl_vlan_pcp == 0
      result << :nw_tos if nw_tos == 0
      result
    end
    # rubocop:enable AbcSize
    # rubocop:enable CyclomaticComplexity
    # rubocop:enable PerceivedComplexity
    # rubocop:enable MethodLength
  end
end
