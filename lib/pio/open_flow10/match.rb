require 'English'
require 'bindata'
require 'pio/type/ip_address'
require 'pio/type/mac_address'

module Pio
  module OpenFlow10
    # Fields to match against flows
    class Match
      # Flow wildcards
      class Wildcards < BinData::Primitive
        BITS = {
          in_port: 1 << 0,
          vlan_vid: 1 << 1,
          source_mac_address: 1 << 2,
          destination_mac_address: 1 << 3,
          ether_type: 1 << 4,
          ip_protocol: 1 << 5,
          transport_source_port: 1 << 6,
          transport_destination_port: 1 << 7,
          source_ip_address: 0,
          source_ip_address0: 1 << 8,
          source_ip_address1: 1 << 9,
          source_ip_address2: 1 << 10,
          source_ip_address3: 1 << 11,
          source_ip_address4: 1 << 12,
          source_ip_address_all: 1 << 13,
          destination_ip_address: 0,
          destination_ip_address0: 1 << 14,
          destination_ip_address1: 1 << 15,
          destination_ip_address2: 1 << 16,
          destination_ip_address3: 1 << 17,
          destination_ip_address4: 1 << 18,
          destination_ip_address_all: 1 << 19,
          vlan_priority: 1 << 20,
          tos: 1 << 21
        }
        NW_FLAGS = [:source_ip_address, :destination_ip_address]
        FLAGS = BITS.keys.select { |each| !(/^(source|destination)_ip/=~ each) }

        endian :big

        uint32 :flags

        # This method smells of :reek:FeatureEnvy
        def get
          BITS.each_with_object(Hash.new(0)) do |(key, bit), memo|
            next if flags & bit == 0
            if /(source_ip_address|destination_ip_address)(\d)/=~ key
              memo[$LAST_MATCH_INFO[1].to_sym] |= 1 << $LAST_MATCH_INFO[2].to_i
            else
              memo[key] = true
            end
          end
        end

        def set(params)
          self.flags = params.inject(0) do |memo, (key, val)|
            memo | case key
                   when :source_ip_address, :destination_ip_address
                     (params.fetch(key) & 31) <<
                       (key == :source_ip_address ? 8 : 14)
                   else
                     val ? BITS.fetch(key) : 0
                   end
          end
        end

        def source_ip_address
          get.fetch(:source_ip_address)
        rescue KeyError
          0
        end

        def destination_ip_address
          get.fetch(:destination_ip_address)
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
        mac_address :source_mac_address
        mac_address :destination_mac_address
        uint16 :vlan_vid
        uint8 :vlan_priority
        uint8 :padding1
        hide :padding1
        uint16 :ether_type
        uint8 :tos
        uint8 :ip_protocol
        uint16 :padding2
        hide :padding2
        match_ip_address :source_ip_address,
                         bitcount: -> { wildcards.source_ip_address }
        match_ip_address :destination_ip_address,
                         bitcount: -> { wildcards.destination_ip_address }
        uint16 :transport_source_port
        uint16 :transport_destination_port
      end

      def self.read(binary)
        MatchFormat.read binary
      end

      # rubocop:disable MethodLength
      # This method smells of :reek:FeatureEnvy
      # This method smells of :reek:DuplicateMethodCall
      def initialize(user_options = {})
        flags = Wildcards::FLAGS.each_with_object({}) do |each, memo|
          memo[each] = true unless user_options.key?(each)
        end
        Wildcards::NW_FLAGS.each_with_object(flags) do |each, memo|
          if user_options.key?(each)
            memo[each] = 32 - IPv4Address.new(user_options[each]).prefixlen
          else
            memo["#{each}_all".to_sym] = true
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
end
