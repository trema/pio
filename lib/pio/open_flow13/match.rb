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
      # OFPXMC_NXM_1 TLV value
      class NiciraMatchExtensionValue < BinData::Record
        OXM_CLASS = 0x1
      end

      # OFPXMC_OPENFLOW_BASIC TLV value
      class OpenFlowBasicValue < BinData::Record
        OXM_CLASS = 0x8000
      end

      # OFPXMC_EXPERIMENTER TLV value
      class ExperimenterValue < BinData::Record
        OXM_CLASS = 0xFFFF
      end

      # The value of OXM_OF_IN_PORT match field.
      class InPort < OpenFlowBasicValue
        OXM_FIELD = 0

        endian :big

        uint32 :in_port

        def length
          4
        end
      end

      # The value of OXM_OF_METADATA match field
      class Metadata < OpenFlowBasicValue
        OXM_FIELD = 2

        endian :big

        uint64 :metadata

        def length
          8
        end
      end

      # Masked OXM_OF_METADATA match field
      class MaskedMetadata < OpenFlowBasicValue
        endian :big

        uint64 :metadata
        uint64 :metadata_mask

        def length
          16
        end
      end

      # The value of OXM_OF_ETH_DST match field.
      class DestinationMacAddress < OpenFlowBasicValue
        OXM_FIELD = 3

        endian :big

        mac_address :destination_mac_address

        def length
          6
        end
      end

      # The value of OXM_OF_ETH_SRC match field.
      class SourceMacAddress < OpenFlowBasicValue
        OXM_FIELD = 4

        endian :big

        mac_address :source_mac_address

        def length
          6
        end
      end

      # Masked OXM_OF_ETH_DST match field.
      class MaskedDestinationMacAddress < OpenFlowBasicValue
        endian :big

        mac_address :destination_mac_address
        mac_address :destination_mac_address_mask

        def length
          12
        end
      end

      # Masked OXM_OF_ETH_SRC match field.
      class MaskedSourceMacAddress < OpenFlowBasicValue
        endian :big

        mac_address :source_mac_address
        mac_address :source_mac_address_mask

        def length
          12
        end
      end

      # The value of OXM_OF_ETH_TYPE match field.
      class EtherType < OpenFlowBasicValue
        OXM_FIELD = 5

        endian :big

        uint16 :ether_type

        def length
          2
        end
      end

      # The value of OXM_OF_VLAN_VID match field
      class VlanVid < OpenFlowBasicValue
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
      class VlanPcp < OpenFlowBasicValue
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
      class IpDscp < OpenFlowBasicValue
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
      class IpEcn < OpenFlowBasicValue
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
      class IpProtocol < OpenFlowBasicValue
        OXM_FIELD = 10

        endian :big

        uint8 :ip_protocol

        def length
          1
        end
      end

      # The value of OXM_OF_IPV4_SRC
      class Ipv4SourceAddress < OpenFlowBasicValue
        OXM_FIELD = 11

        endian :big

        ip_address :ipv4_source_address

        def length
          4
        end
      end

      # The value of masked OXM_OF_IPV4_SRC
      class MaskedIpv4SourceAddress < OpenFlowBasicValue
        OXM_FIELD = 11

        endian :big
        ip_address :ipv4_source_address
        ip_address :ipv4_source_address_mask

        def length
          8
        end
      end

      # The value of OXM_OF_IPV4_DST
      class Ipv4DestinationAddress < OpenFlowBasicValue
        OXM_FIELD = 12

        endian :big

        ip_address :ipv4_destination_address

        def length
          4
        end
      end

      # The value of masked OXM_OF_IPV4_DST
      class MaskedIpv4DestinationAddress < OpenFlowBasicValue
        OXM_FIELD = 12

        endian :big
        ip_address :ipv4_destination_address
        ip_address :ipv4_destination_address_mask

        def length
          8
        end
      end

      # The value of OXM_OF_TCP_SRC
      class TcpSourcePort < OpenFlowBasicValue
        OXM_FIELD = 13

        endian :big

        uint16 :tcp_source_port

        def length
          2
        end
      end

      # The value of OXM_OF_TCP_DST
      class TcpDestinationPort < OpenFlowBasicValue
        OXM_FIELD = 14

        endian :big

        uint16 :tcp_destination_port

        def length
          2
        end
      end

      # The value of OXM_OF_UDP_SRC
      class UdpSourcePort < OpenFlowBasicValue
        OXM_FIELD = 15

        endian :big

        uint16 :udp_source_port

        def length
          2
        end
      end

      # The value of OXM_OF_UDP_SRC
      class UdpDestinationPort < OpenFlowBasicValue
        OXM_FIELD = 16

        endian :big

        uint16 :udp_destination_port

        def length
          2
        end
      end

      # The value of OXM_OF_SCTP_SRC
      class SctpSourcePort < OpenFlowBasicValue
        OXM_FIELD = 17

        endian :big

        uint16 :sctp_source_port

        def length
          2
        end
      end

      # The value of OXM_OF_SCTP_DST
      class SctpDestinationPort < OpenFlowBasicValue
        OXM_FIELD = 18

        endian :big

        uint16 :sctp_destination_port

        def length
          2
        end
      end

      # The value of OXM_OF_ICMPV4_TYPE
      class Icmpv4Type < OpenFlowBasicValue
        OXM_FIELD = 19

        endian :big

        uint8 :icmpv4_type

        def length
          1
        end
      end

      # The value of OXM_OF_ICMPV4_CODE
      class Icmpv4Code < OpenFlowBasicValue
        OXM_FIELD = 20

        endian :big

        uint8 :icmpv4_code

        def length
          1
        end
      end

      # The value of OXM_OF_ARP_OP
      class ArpOperation < OpenFlowBasicValue
        OXM_FIELD = 21

        endian :big

        uint16 :arp_operation

        def length
          2
        end
      end

      # The value of OXM_OF_ARP_SPA
      class ArpSenderProtocolAddress < OpenFlowBasicValue
        OXM_FIELD = 22

        endian :big

        ip_address :arp_sender_protocol_address

        def length
          4
        end
      end

      # The value of masked OXM_OF_ARP_SPA
      class MaskedArpSenderProtocolAddress < OpenFlowBasicValue
        OXM_FIELD = 22

        endian :big
        ip_address :arp_sender_protocol_address
        ip_address :arp_sender_protocol_address_mask

        def length
          8
        end
      end

      # The value of OXM_OF_ARP_TPA
      class ArpTargetProtocolAddress < OpenFlowBasicValue
        OXM_FIELD = 23

        endian :big

        ip_address :arp_target_protocol_address

        def length
          4
        end
      end

      # The value of masked OXM_OF_ARP_TPA
      class MaskedArpTargetProtocolAddress < OpenFlowBasicValue
        OXM_FIELD = 23

        endian :big
        ip_address :arp_target_protocol_address
        ip_address :arp_target_protocol_address_mask

        def length
          8
        end
      end

      # The value of OXM_OF_ARP_SHA match field.
      class ArpSenderHardwareAddress < OpenFlowBasicValue
        OXM_FIELD = 24

        endian :big

        mac_address :arp_sender_hardware_address

        def length
          6
        end
      end

      # Masked OXM_OF_ARP_SHA match field.
      class MaskedArpSenderHardwareAddress < OpenFlowBasicValue
        OXM_FIELD = 24

        endian :big

        mac_address :arp_sender_hardware_address
        mac_address :arp_sender_hardware_address_mask

        def length
          12
        end
      end

      # The value of OXM_OF_ARP_THA match field.
      class ArpTargetHardwareAddress < OpenFlowBasicValue
        OXM_FIELD = 25

        endian :big

        mac_address :arp_target_hardware_address

        def length
          6
        end
      end

      # Masked OXM_OF_ARP_THA match field.
      class MaskedArpTargetHardwareAddress < OpenFlowBasicValue
        OXM_FIELD = 25

        endian :big

        mac_address :arp_target_hardware_address
        mac_address :arp_target_hardware_address_mask

        def length
          12
        end
      end

      # The value of OXM_OF_IPV6_SRC
      class Ipv6SourceAddress < OpenFlowBasicValue
        OXM_FIELD = 26

        endian :big

        ipv6_address :ipv6_source_address

        def length
          16
        end
      end

      # The value of masked OXM_OF_IPV6_SRC
      class MaskedIpv6SourceAddress < OpenFlowBasicValue
        OXM_FIELD = 26

        endian :big

        ipv6_address :ipv6_source_address
        ipv6_address :ipv6_source_address_mask

        def length
          32
        end
      end

      # The value of OXM_OF_IPV6_DST
      class Ipv6DestinationAddress < OpenFlowBasicValue
        OXM_FIELD = 27

        endian :big

        ipv6_address :ipv6_destination_address

        def length
          16
        end
      end

      # The value of OXM_OF_IPV6_DST
      class MaskedIpv6DestinationAddress < OpenFlowBasicValue
        OXM_FIELD = 27

        endian :big

        ipv6_address :ipv6_destination_address
        ipv6_address :ipv6_destination_address_mask

        def length
          32
        end
      end

      # The value of OXM_OF_TUNNEL_ID match field
      class TunnelId < OpenFlowBasicValue
        OXM_FIELD = 38

        endian :big

        uint64 :tunnel_id

        def length
          8
        end
      end

      # Masked OXM_OF_TUNNEL_ID match field
      class MaskedTunnelId < OpenFlowBasicValue
        endian :big

        uint64 :tunnel_id
        uint64 :tunnel_id_mask

        def length
          16
        end
      end

      # NXM_NX_REG0 match field
      class Reg0 < NiciraMatchExtensionValue
        OXM_FIELD = 0

        endian :big

        uint32 :reg0

        def length
          4
        end
      end

      # Masked NXM_NX_REG0 match field
      class MaskedReg0 < NiciraMatchExtensionValue
        endian :big

        uint32 :reg0
        uint32 :reg0_mask

        def length
          8
        end
      end

      # NXM_NX_REG1 match field
      class Reg1 < NiciraMatchExtensionValue
        OXM_FIELD = 1

        endian :big

        uint32 :reg1

        def length
          4
        end
      end

      # Masked NXM_NX_REG1 match field
      class MaskedReg1 < NiciraMatchExtensionValue
        endian :big

        uint32 :reg1
        uint32 :reg1_mask

        def length
          8
        end
      end

      # NXM_NX_REG2 match field
      class Reg2 < NiciraMatchExtensionValue
        OXM_FIELD = 2

        endian :big

        uint32 :reg2

        def length
          4
        end
      end

      # Masked NXM_NX_REG2 match field
      class MaskedReg2 < NiciraMatchExtensionValue
        endian :big

        uint32 :reg2
        uint32 :reg2_mask

        def length
          8
        end
      end

      # NXM_NX_REG3 match field
      class Reg3 < NiciraMatchExtensionValue
        OXM_FIELD = 3

        endian :big

        uint32 :reg3

        def length
          4
        end
      end

      # Masked NXM_NX_REG3 match field
      class MaskedReg3 < NiciraMatchExtensionValue
        endian :big

        uint32 :reg3
        uint32 :reg3_mask

        def length
          8
        end
      end

      # NXM_NX_REG4 match field
      class Reg4 < NiciraMatchExtensionValue
        OXM_FIELD = 4

        endian :big

        uint32 :reg4

        def length
          4
        end
      end

      # Masked NXM_NX_REG4 match field
      class MaskedReg4 < NiciraMatchExtensionValue
        endian :big

        uint32 :reg4
        uint32 :reg4_mask

        def length
          8
        end
      end

      # NXM_NX_REG5 match field
      class Reg5 < NiciraMatchExtensionValue
        OXM_FIELD = 5

        endian :big

        uint32 :reg5

        def length
          4
        end
      end

      # Masked NXM_NX_REG5 match field
      class MaskedReg5 < NiciraMatchExtensionValue
        endian :big

        uint32 :reg5
        uint32 :reg5_mask

        def length
          8
        end
      end

      # NXM_NX_REG6 match field
      class Reg6 < NiciraMatchExtensionValue
        OXM_FIELD = 6

        endian :big

        uint32 :reg6

        def length
          4
        end
      end

      # Masked NXM_NX_REG6 match field
      class MaskedReg6 < NiciraMatchExtensionValue
        endian :big

        uint32 :reg6
        uint32 :reg6_mask

        def length
          8
        end
      end

      # NXM_NX_REG7 match field
      class Reg7 < NiciraMatchExtensionValue
        OXM_FIELD = 7

        endian :big

        uint32 :reg7

        def length
          4
        end
      end

      # Masked NXM_NX_REG7 match field
      class MaskedReg7 < NiciraMatchExtensionValue
        endian :big

        uint32 :reg7
        uint32 :reg7_mask

        def length
          8
        end
      end

      # OXM format
      class Oxm < BinData::Record
        # Experimenter part, data will use oxm_length
        class Experimenter < BinData::Record
          endian :big

          bit7 :oxm_field
          bit1 :oxm_hasmask
          uint8 :oxm_length, value: -> { data.length + 4 }
          uint32 :experimenter
          string :data, read_length: -> { oxm_length - 4 }

          def length
            oxm_length + 2
          end
        end

        # Nicira match extension
        class NiciraMatchExtension < BinData::Record
          endian :big

          bit7 :oxm_field
          bit1 :oxm_hasmask
          uint8 :oxm_length, value: -> { tlv_value.length }
          choice :tlv_value,
                 selection: :choose_tlv_value do
            reg0 Reg0
            masked_reg0 MaskedReg0
            reg1 Reg1
            masked_reg1 MaskedReg1
            reg2 Reg2
            masked_reg2 MaskedReg2
            reg3 Reg3
            masked_reg3 MaskedReg3
            reg4 Reg4
            masked_reg4 MaskedReg4
            reg5 Reg5
            masked_reg5 MaskedReg5
            reg6 Reg6
            masked_reg6 MaskedReg6
            reg7 Reg7
            masked_reg7 MaskedReg7
          end

          def length
            tlv_value.length + 2
          end

          def masked?
            oxm_hasmask == 1
          end

          def method_missing(method, *args, &block)
            tlv_value.__send__ method, *args, &block
          end

          private

          # rubocop:disable AbcSize
          # rubocop:disable CyclomaticComplexity
          # rubocop:disable PerceivedComplexity
          # rubocop:disable MethodLength
          def choose_tlv_value
            case oxm_field
            when Reg0::OXM_FIELD
              masked? ? MaskedReg0 : Reg0
            when Reg1::OXM_FIELD
              masked? ? MaskedReg1 : Reg1
            when Reg2::OXM_FIELD
              masked? ? MaskedReg2 : Reg2
            when Reg3::OXM_FIELD
              masked? ? MaskedReg3 : Reg3
            when Reg4::OXM_FIELD
              masked? ? MaskedReg4 : Reg4
            when Reg5::OXM_FIELD
              masked? ? MaskedReg5 : Reg5
            when Reg6::OXM_FIELD
              masked? ? MaskedReg6 : Reg6
            when Reg7::OXM_FIELD
              masked? ? MaskedReg7 : Reg7
            else
              fail "Unknown OXM field value: #{oxm_field}"
            end
          end
          # rubocop:enable AbcSize
          # rubocop:enable CyclomaticComplexity
          # rubocop:enable PerceivedComplexity
          # rubocop:enable MethodLength
        end

        # rubocop:disable ClassLength
        # OpenflowBasic part, tlv_value will use oxm_field, oxm_hasmask
        class OpenflowBasic < BinData::Record
          endian :big

          bit7 :oxm_field
          bit1 :oxm_hasmask
          uint8 :oxm_length, value: -> { tlv_value.length }
          choice :tlv_value,
                 selection: :choose_tlv_value do
            in_port InPort
            metadata Metadata
            masked_metadata MaskedMetadata
            destination_mac_address DestinationMacAddress
            masked_destination_mac_address MaskedDestinationMacAddress
            source_mac_address SourceMacAddress
            masked_source_mac_address MaskedSourceMacAddress
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
            sctp_source_port SctpSourcePort
            sctp_destination_port SctpDestinationPort
            arp_operation ArpOperation
            arp_sender_protocol_address ArpSenderProtocolAddress
            masked_arp_sender_protocol_address MaskedArpSenderProtocolAddress
            arp_target_protocol_address ArpTargetProtocolAddress
            masked_arp_target_protocol_address MaskedArpTargetProtocolAddress
            arp_sender_hardware_address ArpSenderHardwareAddress
            masked_arp_sender_hardware_address MaskedArpSenderHardwareAddress
            arp_target_hardware_address ArpTargetHardwareAddress
            masked_arp_target_hardware_address MaskedArpTargetHardwareAddress
            icmpv4_type Icmpv4Type
            icmpv4_code Icmpv4Code
            ipv6_source_address Ipv6SourceAddress
            masked_ipv6_source_address MaskedIpv6SourceAddress
            ipv6_destination_address Ipv6DestinationAddress
            masked_ipv6_destination_address MaskedIpv6DestinationAddress
            tunnel_id TunnelId
            masked_tunnel_id MaskedTunnelId
          end

          def length
            tlv_value.length + 2
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
            when DestinationMacAddress::OXM_FIELD
              masked? ? MaskedDestinationMacAddress : DestinationMacAddress
            when SourceMacAddress::OXM_FIELD
              masked? ? MaskedSourceMacAddress : SourceMacAddress
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
            when SctpSourcePort::OXM_FIELD
              SctpSourcePort
            when SctpDestinationPort::OXM_FIELD
              SctpDestinationPort
            when Icmpv4Type::OXM_FIELD
              Icmpv4Type
            when Icmpv4Code::OXM_FIELD
              Icmpv4Code
            when ArpOperation::OXM_FIELD
              ArpOperation
            when ArpSenderProtocolAddress::OXM_FIELD
              if masked?
                MaskedArpSenderProtocolAddress
              else
                ArpSenderProtocolAddress
              end
            when ArpTargetProtocolAddress::OXM_FIELD
              if masked?
                MaskedArpTargetProtocolAddress
              else
                ArpTargetProtocolAddress
              end
            when ArpSenderHardwareAddress::OXM_FIELD
              if masked?
                MaskedArpSenderHardwareAddress
              else
                ArpSenderHardwareAddress
              end
            when ArpTargetHardwareAddress::OXM_FIELD
              if masked?
                MaskedArpTargetHardwareAddress
              else
                ArpTargetHardwareAddress
              end
            when Ipv6SourceAddress::OXM_FIELD
              if masked?
                MaskedIpv6SourceAddress
              else
                Ipv6SourceAddress
              end
            when Ipv6DestinationAddress::OXM_FIELD
              masked? ? MaskedIpv6DestinationAddress : Ipv6DestinationAddress
            when TunnelId::OXM_FIELD
              masked? ? MaskedTunnelId : TunnelId
            else
              fail "Unknown OXM field value: #{oxm_field}"
            end
          end
          # rubocop:enable MethodLength
          # rubocop:enable CyclomaticComplexity
          # rubocop:enable PerceivedComplexity
          # rubocop:enable AbcSize
        end
        # rubocop:enable MethodLength

        # OXM match field.
        class MatchField < BinData::Record
          endian :big

          uint16 :oxm_class
          choice :class_payload, selection: :oxm_class do
            NiciraMatchExtension NiciraMatchExtensionValue::OXM_CLASS
            OpenflowBasic OpenFlowBasicValue::OXM_CLASS
            Experimenter ExperimenterValue::OXM_CLASS
          end

          def oxm_field
            class_payload.oxm_field
          end

          def masked?
            class_payload.oxm_hasmask == 1
          end

          def oxm_length
            class_payload.oxm_length
          end

          def length
            class_payload.length + 2
          end

          def method_missing(method, *args, &block)
            case oxm_class
            when OpenFlowBasicValue::OXM_CLASS
              return class_payload.tlv_value.__send__(method, *args, &block)
            when ExperimenterValue::OXM_CLASS
              return class_payload.__send__(method, *args, &block)
            else
              fail NoMethodError, method.to_s
            end
          end
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

        # rubocop:disable Next
        # rubocop:disable LineLength
        def method_missing(method, *args, &block)
          match_fields.each do |each|
            if each.oxm_class == OpenFlowBasicValue::OXM_CLASS || each.oxm_class == NiciraMatchExtensionValue::OXM_CLASS
              next unless each.class_payload.tlv_value.respond_to?(method)
              return each.class_payload.tlv_value.__send__(
                method, *args, &block)
            end
          end
          fail NoMethodError, method.to_s
        end
        # rubocop:enable Next
        # rubocop:enable LineLength

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
        # rubocop:disable LineLength
        def initialize(user_attrs)
          @match_fields = []

          [:in_port, :ether_type, :ip_protocol, :vlan_vid, :vlan_pcp,
           :ip_dscp, :ip_ecn, :tcp_source_port, :tcp_destination_port,
           :udp_source_port, :udp_destination_port,
           :sctp_source_port, :sctp_destination_port,
           :icmpv4_type, :icmpv4_code, :arp_operation].each do |each|
            next unless user_attrs.key?(each)
            klass = Match.const_get(each.to_s.split('_').map(&:capitalize).join)
            @match_fields << { oxm_class: klass.superclass.const_get(:OXM_CLASS),
                               class_payload: { oxm_field: klass.const_get(:OXM_FIELD),
                                                tlv_value: { each => user_attrs.fetch(each) } } }
          end

          [:metadata, :destination_mac_address, :source_mac_address,
           :ipv4_source_address, :ipv4_destination_address,
           :arp_sender_protocol_address, :arp_target_protocol_address,
           :arp_sender_hardware_address, :arp_target_hardware_address,
           :ipv6_source_address, :ipv6_destination_address, :tunnel_id,
           :reg0, :reg1, :reg2, :reg3, :reg4, :reg5, :reg6, :reg7].each do |each|
            next unless user_attrs.key?(each)
            klass = Match.const_get(each.to_s.split('_').map(&:capitalize).join)
            mask_key = "#{each}_mask".to_sym
            @match_fields << { oxm_class: klass.superclass.const_get(:OXM_CLASS),
                               class_payload: { oxm_field: klass.const_get(:OXM_FIELD),
                                                oxm_hasmask: user_attrs.key?(mask_key) ? 1 : 0,
                                                tlv_value: { each => user_attrs[each],
                                                             mask_key => user_attrs[mask_key] } } }
          end
        end
        # rubocop:enable MethodLength
        # rubocop:enable AbcSize
        # rubocop:enable LineLength

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
