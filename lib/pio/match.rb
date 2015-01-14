require 'English'
require 'bindata'
require 'pio/open_flow'
require 'pio/type/ip_address'
require 'pio/type/mac_address'
require 'forwardable'

module Pio
  # Fields to match against flows
  class Match
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

      # This method smells of :reek:FeatureEnvy
      def get
        BITS.each_with_object(Hash.new(0)) do |(key, bit), memo|
          next if flags & bit == 0
          if /(nw_src|nw_dst)(\d)/=~ key
            memo[$LAST_MATCH_INFO[1].intern] |= 1 << $LAST_MATCH_INFO[2].to_i
          else
            memo[key] = true
          end
        end
      end

      def set(params)
        self.flags = params.keys.map do |each|
          next unless params[each]
          case each
          when :nw_src, :nw_dst
            (params.fetch(each) & 31) << (each == :nw_src ? 8 : 14)
          else
            BITS.fetch(each)
          end
        end.inject(:|) || 0
      end

      def nw_src
        get.fetch(:nw_src)
      rescue KeyError
        0
      end

      def nw_dst
        get.fetch(:nw_dst)
      rescue KeyError
        0
      end
    end

    # IP address
    class MatchIpAddress < BinData::Primitive
      default_parameter bitcount: 0

      array :octets, type: :uint8, initial_length: 4

      def set(value)
        self.octets = IPv4Address.new(value).to_a
      end

      def get
        ipaddr = octets.map { |each| format('%d', each) }.join('.')
        prefixlen = 32 - eval_parameter(:bitcount)
        IPv4Address.new(ipaddr + "/#{prefixlen}")
      end

      def ==(other)
        get == other
      end
    end

    # ofp_match format
    class MatchFormat < BinData::Record
      endian :big

      wildcards :wildcards
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
      match_ip_address :nw_src, bitcount: -> { wildcards.nw_src }
      match_ip_address :nw_dst, bitcount: -> { wildcards.nw_dst }
      uint16 :tp_src
      uint16 :tp_dst
    end

    def self.read(binary)
      MatchFormat.read binary
    end

    extend Forwardable

    def_delegators :@format, :wildcards
    def_delegators :@format, :in_port
    def_delegators :@format, :dl_vlan
    def_delegators :@format, :dl_src
    def_delegators :@format, :dl_dst
    def_delegators :@format, :dl_type
    def_delegators :@format, :nw_proto
    def_delegators :@format, :tp_src
    def_delegators :@format, :tp_dst
    def_delegators :@format, :nw_src
    def_delegators :@format, :nw_src_all
    def_delegators :@format, :nw_dst
    def_delegators :@format, :nw_dst_all
    def_delegators :@format, :dl_vlan_pcp
    def_delegators :@format, :nw_tos
    def_delegators :@format, :to_binary_s

    # rubocop:disable MethodLength
    # rubocop:disable AbcSize
    def initialize(user_options)
      wildcards = {}.tap do |hash|
        hash[:in_port] = !user_options.key?(:in_port)
        hash[:dl_vlan] = !user_options.key?(:dl_vlan)
        hash[:dl_src] = !user_options.key?(:dl_src)
        hash[:dl_dst] = !user_options.key?(:dl_dst)
        hash[:dl_type] = !user_options.key?(:dl_type)
        hash[:nw_proto] = !user_options.key?(:nw_proto)
        hash[:tp_src] = !user_options.key?(:tp_src)
        hash[:tp_dst] = !user_options.key?(:tp_dst)
        if user_options[:nw_src]
          hash[:nw_src] = 32 - IPv4Address.new(user_options[:nw_src]).prefixlen
        end
        hash[:nw_src_all] = !user_options.key?(:nw_src)
        if user_options[:nw_dst]
          hash[:nw_dst] = 32 - IPv4Address.new(user_options[:nw_dst]).prefixlen
        end
        hash[:nw_dst_all] = !user_options.key?(:nw_dst)
        hash[:dl_vlan_pcp] = !user_options.key?(:dl_vlan_pcp)
        hash[:nw_tos] = !user_options.key?(:nw_tos)
        hash.keep_if { |_k, v| v }
      end

      @format = MatchFormat.new({ wildcards: wildcards }.merge user_options)
    end
    # rubocop:enable MethodLength
    # rubocop:enable AbcSize
  end
end
