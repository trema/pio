require 'bindata'
require 'pio/type/ip_address'
require 'pio/type/ipv6_address'
require 'pio/type/mac_address'

# Base module.
module Pio
  # OpenFlow 1.3.
  module OpenFlow13
    # OFPMT_OXM
    MATCH_TYPE_OXM = 1

    # OpenFlow eXtensible Match (OXM)
    class Match
      OXM_CLASS_OPENFLOW_BASIC = 0x8000

      # The value of OXM_OF_IN_PORT match field.
      class InPort < BinData::Record
        OXM_FIELD = 0

        endian :big

        uint32 :in_port

        def length
          4
        end
      end

      # The value of OXM_OF_METADATA match field
      class Metadata < BinData::Record
        OXM_FIELD = 2

        endian :big

        uint64 :metadata

        def length
          8
        end
      end

      # Masked OXM_OF_METADATA match field
      class MaskedMetadata < BinData::Record
        endian :big

        uint64 :metadata
        uint64 :metadata_mask

        def length
          16
        end
      end

      # The value of OXM_OF_ETH_DST match field.
      class EtherDestinationAddress < BinData::Record
        OXM_FIELD = 3

        endian :big

        mac_address :ether_destination_address

        def length
          6
        end
      end

      # The value of OXM_OF_ETH_SRC match field.
      class EtherSourceAddress < BinData::Record
        OXM_FIELD = 4

        endian :big

        mac_address :ether_source_address

        def length
          6
        end
      end

      # Masked OXM_OF_ETH_DST match field.
      class MaskedEtherDestinationAddress < BinData::Record
        endian :big

        mac_address :ether_destination_address
        mac_address :ether_destination_address_mask

        def length
          12
        end
      end

      # Masked OXM_OF_ETH_SRC match field.
      class MaskedEtherSourceAddress < BinData::Record
        endian :big

        mac_address :ether_source_address
        mac_address :ether_source_address_mask

        def length
          12
        end
      end

      # The value of OXM_OF_ETH_TYPE match field.
      class EtherType < BinData::Record
        OXM_FIELD = 5

        endian :big

        uint16 :ether_type

        def length
          2
        end
      end

      # The value of OXM_OF_VLAN_VID match field
      class VlanVid < BinData::Record
        OXM_FIELD = 6

        endian :big

        bit3 :padding
        bit13 :vlan_vid

        hide :padding

        def length
          2
        end
      end

      # The value of OXM_OF_VLAN_PCP match field
      class VlanPcp < BinData::Record
        OXM_FIELD = 7

        endian :big

        bit5 :padding
        bit3 :vlan_pcp

        hide :padding

        def length
          1
        end
      end

      # The value of OXM_OF_IP_DSCP match field
      class IpDscp < BinData::Record
        OXM_FIELD = 8

        endian :big

        bit2 :padding
        bit6 :ip_dscp

        hide :padding

        def length
          1
        end
      end

      # The value of OXM_OF_IP_ECN match field
      class IpEcn < BinData::Record
        OXM_FIELD = 9

        endian :big

        bit6 :padding
        bit2 :ip_ecn

        hide :padding

        def length
          1
        end
      end

      # The value of OXM_OF_IP_PROTO
      class IpProtocol < BinData::Record
        OXM_FIELD = 10

        endian :big

        uint8 :ip_protocol

        def length
          1
        end
      end

      # The value of OXM_OF_IPV4_SRC
      class Ipv4SourceAddress < BinData::Record
        OXM_FIELD = 11

        endian :big

        ip_address :ipv4_source_address

        def length
          4
        end
      end

      # The value of masked OXM_OF_IPV4_SRC
      class MaskedIpv4SourceAddress < BinData::Record
        OXM_FIELD = 11

        endian :big
        ip_address :ipv4_source_address
        ip_address :ipv4_source_address_mask

        def length
          8
        end
      end

      # The value of OXM_OF_IPV4_DST
      class Ipv4DestinationAddress < BinData::Record
        OXM_FIELD = 12

        endian :big

        ip_address :ipv4_destination_address

        def length
          4
        end
      end

      # The value of masked OXM_OF_IPV4_DST
      class MaskedIpv4DestinationAddress < BinData::Record
        OXM_FIELD = 12

        endian :big
        ip_address :ipv4_destination_address
        ip_address :ipv4_destination_address_mask

        def length
          8
        end
      end

      # The value of OXM_OF_TCP_SRC
      class TcpSourcePort < BinData::Record
        OXM_FIELD = 13

        endian :big

        uint16 :tcp_source_port

        def length
          16
        end
      end

      # The value of OXM_OF_TCP_DST
      class TcpDestinationPort < BinData::Record
        OXM_FIELD = 14

        endian :big

        uint16 :tcp_destination_port

        def length
          16
        end
      end

      # The value of OXM_OF_UDP_SRC
      class UdpSourcePort < BinData::Record
        OXM_FIELD = 15

        endian :big

        uint16 :udp_source_port

        def length
          16
        end
      end

      # The value of OXM_OF_UDP_SRC
      class UdpDestinationPort < BinData::Record
        OXM_FIELD = 16

        endian :big

        uint16 :udp_destination_port

        def length
          16
        end
      end

      # The value of OXM_OF_IPV6_SRC
      class Ipv6SourceAddress < BinData::Record
        OXM_FIELD = 26

        endian :big

        ipv6_address :ipv6_source_address

        def length
          128
        end
      end

      # The value of masked OXM_OF_IPV6_SRC
      class MaskedIpv6SourceAddress < BinData::Record
        OXM_FIELD = 26

        endian :big

        ipv6_address :ipv6_source_address
        ipv6_address :ipv6_source_address_mask

        def length
          256
        end
      end

      # The value of OXM_OF_IPV6_DST
      class Ipv6DestinationAddress < BinData::Record
        OXM_FIELD = 27

        endian :big

        ipv6_address :ipv6_destination_address

        def length
          128
        end
      end

      # The value of OXM_OF_IPV6_DST
      class MaskedIpv6DestinationAddress < BinData::Record
        OXM_FIELD = 27

        endian :big

        ipv6_address :ipv6_destination_address
        ipv6_address :ipv6_destination_address_mask

        def length
          256
        end
      end

      # OXM format
      class Oxm < BinData::Record
        # OXM match field.
        class MatchField < BinData::Record
          endian :big

          uint16 :oxm_class, value: OXM_CLASS_OPENFLOW_BASIC
          bit7 :oxm_field
          bit1 :oxm_hasmask
          uint8 :oxm_length, value: -> { tlv_value.length }
          choice :tlv_value,
                 read_length: :oxm_length,
                 selection: :choose_tlv_value do
            in_port InPort
            metadata Metadata
            masked_metadata MaskedMetadata
            ether_destination_address EtherDestinationAddress
            masked_ether_destination_address MaskedEtherDestinationAddress
            ether_source_address EtherSourceAddress
            masked_ether_source_address MaskedEtherSourceAddress
            ether_type EtherType
            vlan_vid VlanVid
            vlan_pcp VlanPcp
            ip_dscp IpDscp
            ip_ecn IpEcn
            ipv4_source_address Ipv4SourceAddress
            masked_ipv4_source_address MaskedIpv4SourceAddress
            ipv4_destination_address Ipv4DestinationAddress
            masked_ipv4_destination_address MaskedIpv4DestinationAddress
            ip_protocol IpProtocol
            tcp_source_port TcpSourcePort
            tcp_destination_port TcpDestinationPort
            udp_source_port UdpSourcePort
            udp_destination_port UdpDestinationPort
            ipv6_source_address Ipv6SourceAddress
            masked_ipv6_source_address MaskedIpv6SourceAddress
            ipv6_destination_address Ipv6DestinationAddress
            masked_ipv6_destination_address MaskedIpv6DestinationAddress
          end

          def length
            tlv_value.length + 4
          end

          def masked?
            oxm_hasmask == 1
          end

          def method_missing(method, *args, &block)
            tlv_value.__send__ method, *args, &block
          end

          private

          # rubocop:disable MethodLength
          # rubocop:disable CyclomaticComplexity
          # rubocop:disable PerceivedComplexity
          # rubocop:disable AbcSize
          def choose_tlv_value
            case oxm_field
            when InPort::OXM_FIELD
              InPort
            when Metadata::OXM_FIELD
              masked? ? MaskedMetadata : Metadata
            when EtherDestinationAddress::OXM_FIELD
              masked? ? MaskedEtherDestinationAddress : EtherDestinationAddress
            when EtherSourceAddress::OXM_FIELD
              masked? ? MaskedEtherSourceAddress : EtherSourceAddress
            when EtherType::OXM_FIELD
              EtherType
            when VlanVid::OXM_FIELD
              VlanVid
            when VlanPcp::OXM_FIELD
              VlanPcp
            when IpDscp::OXM_FIELD
              IpDscp
            when IpEcn::OXM_FIELD
              IpEcn
            when Ipv4SourceAddress::OXM_FIELD
              masked? ? MaskedIpv4SourceAddress : Ipv4SourceAddress
            when Ipv4DestinationAddress::OXM_FIELD
              masked? ? MaskedIpv4DestinationAddress : Ipv4DestinationAddress
            when IpProtocol::OXM_FIELD
              IpProtocol
            when TcpSourcePort::OXM_FIELD
              TcpSourcePort
            when TcpDestinationPort::OXM_FIELD
              TcpDestinationPort
            when UdpSourcePort::OXM_FIELD
              UdpSourcePort
            when UdpDestinationPort::OXM_FIELD
              UdpDestinationPort
            when Ipv6SourceAddress::OXM_FIELD
              masked? ? MaskedIpv6SourceAddress : Ipv6SourceAddress
            when Ipv6DestinationAddress::OXM_FIELD
              masked? ? MaskedIpv6DestinationAddress : Ipv6DestinationAddress
            else
              fail "Unknown OXM field value: #{oxm_field}"
            end
          end
          # rubocop:enable MethodLength
          # rubocop:enable CyclomaticComplexity
          # rubocop:enable PerceivedComplexity
          # rubocop:enable AbcSize
        end

        endian :big

        uint16 :match_type, value: MATCH_TYPE_OXM
        uint16 :match_length, initial_value: -> { 4 + tlv_total_length }
        array(:match_fields,
              type: :match_field,
              read_until: -> { tlv_length_left <= 5 },
              onlyif: -> { match_length > 4 })
        string :padding, length: :padding_length
        hide :padding

        def length
          match_length + padding_length
        end

        def method_missing(method, *args, &block)
          match_fields.each do |each|
            next unless each.tlv_value.respond_to?(method)
            return each.tlv_value.__send__(method, *args, &block)
          end
          fail NoMethodError, method.to_s
        end

        private

        def tlv_length_left
          match_length - tlv_total_length
        end

        def tlv_total_length
          if match_fields.size > 0
            match_fields.map(&:length).inject(&:+)
          else
            0
          end
        end

        def padding_length
          (match_length + 7) / 8 * 8 - match_length
        end
      end

      # Match.new option parser.
      class Options
        # rubocop:disable MethodLength
        # rubocop:disable AbcSize
        def initialize(user_attrs)
          @match_fields = []

          [:in_port, :ether_type, :ip_protocol, :vlan_vid, :vlan_pcp,
           :ip_dscp, :ip_ecn, :tcp_source_port, :tcp_destination_port,
           :udp_source_port, :udp_destination_port].each do |each|
            next unless user_attrs.key?(each)
            klass = Match.const_get(each.to_s.split('_').map(&:capitalize).join)
            @match_fields << { oxm_field: klass.const_get(:OXM_FIELD),
                               tlv_value: { each => user_attrs.fetch(each) } }
          end

          [:metadata, :ether_destination_address, :ether_source_address,
           :ipv4_source_address, :ipv4_destination_address,
           :ipv6_source_address, :ipv6_destination_address].each do |each|
            next unless user_attrs.key?(each)
            klass = Match.const_get(each.to_s.split('_').map(&:capitalize).join)
            mask_key = "#{each}_mask".to_sym
            @match_fields <<
              { oxm_field: klass.const_get(:OXM_FIELD),
                oxm_hasmask: user_attrs.key?(mask_key) ? 1 : 0,
                tlv_value: { each => user_attrs[each],
                             mask_key => user_attrs[mask_key] } }
          end
        end
        # rubocop:enable MethodLength
        # rubocop:enable AbcSize

        def to_hash
          { match_fields: @match_fields }
        end
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Oxm.read(raw_data))
        end
      end

      def initialize(user_attrs = {})
        @format = if user_attrs.empty?
                    Oxm.new
                  else
                    Oxm.new(Options.new(user_attrs).to_hash)
                  end
      end

      def length
        @format.to_binary_s.length
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end
  end
end
