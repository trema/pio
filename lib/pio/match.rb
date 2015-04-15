require 'English'
require 'bindata'
require 'pio/open_flow'
require 'pio/type/ip_address'
require 'pio/type/mac_address'

module Pio
  # Fields to match against flows
  class Match
    # Flow wildcards
    class Wildcards < BinData::Primitive
      BITS = {
        in_port: 1 << 0,
        dl_vlan: 1 << 1,
        ether_source_address: 1 << 2,
        ether_destination_address: 1 << 3,
        ether_type: 1 << 4,
        ip_protocol: 1 << 5,
        tp_source: 1 << 6,
        tp_destination: 1 << 7,
        ip_source_address: 0,
        ip_source_address0: 1 << 8,
        ip_source_address1: 1 << 9,
        ip_source_address2: 1 << 10,
        ip_source_address3: 1 << 11,
        ip_source_address4: 1 << 12,
        ip_source_address_all: 1 << 13,
        ip_destination_address: 0,
        ip_destination_address0: 1 << 14,
        ip_destination_address1: 1 << 15,
        ip_destination_address2: 1 << 16,
        ip_destination_address3: 1 << 17,
        ip_destination_address4: 1 << 18,
        ip_destination_address_all: 1 << 19,
        dl_vlan_pcp: 1 << 20,
        ip_tos: 1 << 21
      }
      NW_FLAGS = [:ip_source_address, :ip_destination_address]
      FLAGS = BITS.keys.select { |each| !(/^ip_(source|destination)/=~ each) }

      endian :big

      uint32 :flags

      # This method smells of :reek:FeatureEnvy
      def get
        BITS.each_with_object(Hash.new(0)) do |(key, bit), memo|
          next if flags & bit == 0
          if /(ip_source_address|ip_destination_address)(\d)/=~ key
            memo[$LAST_MATCH_INFO[1].intern] |= 1 << $LAST_MATCH_INFO[2].to_i
          else
            memo[key] = true
          end
        end
      end

      def set(params)
        self.flags = params.inject(0) do |memo, (key, val)|
          memo | case key
                 when :ip_source_address, :ip_destination_address
                   (params.fetch(key) & 31) <<
                     (key == :ip_source_address ? 8 : 14)
                 else
                   val ? BITS.fetch(key) : 0
                 end
        end
      end

      def ip_source_address
        get.fetch(:ip_source_address)
      rescue KeyError
        0
      end

      def ip_destination_address
        get.fetch(:ip_destination_address)
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
      mac_address :ether_source_address
      mac_address :ether_destination_address
      uint16 :dl_vlan
      uint8 :dl_vlan_pcp
      uint8 :padding1
      hide :padding1
      uint16 :ether_type
      uint8 :ip_tos
      uint8 :ip_protocol
      uint16 :padding2
      hide :padding2
      match_ip_address :ip_source_address,
                       bitcount: -> { wildcards.ip_source_address }
      match_ip_address :ip_destination_address,
                       bitcount: -> { wildcards.ip_destination_address }
      uint16 :tp_source
      uint16 :tp_destination
    end

    def self.read(binary)
      MatchFormat.read binary
    end

    # rubocop:disable MethodLength
    # This method smells of :reek:FeatureEnvy
    # This method smells of :reek:DuplicateMethodCall
    def initialize(user_options)
      flags = Wildcards::FLAGS.each_with_object({}) do |each, memo|
        memo[each] = true unless user_options.key?(each)
      end
      Wildcards::NW_FLAGS.each_with_object(flags) do |each, memo|
        if user_options.key?(each)
          memo[each] = 32 - IPv4Address.new(user_options[each]).prefixlen
        else
          memo["#{each}_all".intern] = true
        end
      end
      @format = MatchFormat.new({ wildcards: flags }.merge user_options)
    end
    # rubocop:enable MethodLength

    def to_binary
      @format.to_binary_s
    end

    def ==(other)
      return false unless other
      to_binary == other.to_binary
    end

    def method_missing(method, *args, &block)
      @format.__send__ method, *args, &block
    end
  end
end
