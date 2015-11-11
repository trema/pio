require 'pio/open_flow13/match'

# rubocop:disable LineLength
describe Pio::OpenFlow13::Match do
  describe '.new' do
    When(:match) { Pio::OpenFlow13::Match.new }
    Then { match.match_fields == [] }
    And { match.class == Pio::OpenFlow13::Match }
    And { match.length == 8 }
    And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
    And { match.match_length == 4 }

    context 'with in_port: 1' do
      When(:match) { Pio::OpenFlow13::Match.new(in_port: 1) }
      Then { match.in_port == 1 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 12 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::InPort::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 4 }
    end

    context "with source_mac_address: '01:02:03:04:05:06'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(source_mac_address: '01:02:03:04:05:06')
      end
      Then { match.source_mac_address == '01:02:03:04:05:06' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 14 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::SourceMacAddress::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 6 }
    end

    context 'with metadata: 1' do
      When(:match) do
        Pio::OpenFlow13::Match.new(metadata: 1)
      end
      Then { match.metadata == 1 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 16 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::Metadata::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 8 }
    end

    context 'with metadata: 1, metadata_mask: 1' do
      When(:match) do
        Pio::OpenFlow13::Match.new(metadata: 1, metadata_mask: 1)
      end
      Then { match.metadata == 1 }
      Then { match.metadata_mask == 1 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 24 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::Metadata::OXM_FIELD
      end
      And { match.match_fields[0].masked? == true }
      And { match.match_fields[0].oxm_length == 16 }
    end

    context "with source_mac_address: '01:02:03:04:05:06', source_mac_address_mask: 'ff:ff:ff:00:00:00'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(source_mac_address: '01:02:03:04:05:06',
                                   source_mac_address_mask: 'ff:ff:ff:00:00:00')
      end
      Then { match.source_mac_address == '01:02:03:04:05:06' }
      Then { match.source_mac_address_mask == 'ff:ff:ff:00:00:00' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 20 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::SourceMacAddress::OXM_FIELD
      end
      And { match.match_fields[0].masked? == true }
      And { match.match_fields[0].oxm_length == 12 }
    end

    context 'with ether_type: 0x0800' do
      When(:match) { Pio::OpenFlow13::Match.new(ether_type: 0x0800) }
      Then { match.ether_type == 0x0800 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 10 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::EtherType::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with vlan_vid: 10' do
      When(:match) { Pio::OpenFlow13::Match.new(vlan_vid: 10) }
      Then { match.vlan_vid == 10 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 10 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::VlanVid::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with vlan_vid: 10, vlan_pcp: 5' do
      When(:match) { Pio::OpenFlow13::Match.new(vlan_vid: 10, vlan_pcp: 5) }
      Then { match.vlan_vid == 10 }
      Then { match.vlan_pcp == 5 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 15 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::VlanPcp::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with ether_type: 0x0800, ip_dscp: 0x2e' do
      When(:match) { Pio::OpenFlow13::Match.new(ether_type: 0x0800, ip_dscp: 0x2e) }
      Then { match.ether_type == 0x0800 }
      Then { match.ip_dscp == 0x2e }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 15 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::IpDscp::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with ether_type: 0x0800, ip_ecn: 3' do
      When(:match) { Pio::OpenFlow13::Match.new(ether_type: 0x0800, ip_ecn: 3) }
      Then { match.ether_type == 0x0800 }
      Then { match.ip_ecn == 3 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 15 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::IpEcn::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context "with ether_type: 0x0800, ipv4_source_address: '1.2.3.4'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(ether_type: 0x0800,
                                   ipv4_source_address: '1.2.3.4')
      end
      Then { match.ether_type == 0x0800 }
      Then { match.ipv4_source_address == '1.2.3.4' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 18 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::EtherType::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::Ipv4SourceAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 4 }
    end

    context "with ether_type: 0x0800, ipv4_destination_address: '1.2.3.4'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(ether_type: 0x0800,
                                   ipv4_destination_address: '1.2.3.4')
      end
      Then { match.ether_type == 0x0800 }
      Then { match.ipv4_destination_address == '1.2.3.4' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 18 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::EtherType::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::Ipv4DestinationAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 4 }
    end

    context 'with ether_type: 0x0800, ip_protocol: 132, sctp_source_port: 22' do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0800,
          ip_protocol: 132,
          sctp_source_port: 22
        )
      end
      Then { match.ether_type == 0x0800 }
      Then { match.ip_protocol == 132 }
      Then { match.sctp_source_port == 22 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 21 }
      And { match.match_fields.size == 3 }
      And do
        match.match_fields[2].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[2].oxm_field ==
          Pio::OpenFlow13::Match::SctpSourcePort::OXM_FIELD
      end
      And { match.match_fields[2].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with ether_type: 0x0800, ip_protocol: 132, sctp_destination_port: 22' do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0800,
          ip_protocol: 132,
          sctp_destination_port: 22
        )
      end
      Then { match.ether_type == 0x0800 }
      Then { match.ip_protocol == 132 }
      Then { match.sctp_destination_port == 22 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 21 }
      And { match.match_fields.size == 3 }
      And do
        match.match_fields[2].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[2].oxm_field ==
          Pio::OpenFlow13::Match::SctpDestinationPort::OXM_FIELD
      end
      And { match.match_fields[2].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with ether_type: 0x0800, ip_protocol: 1, icmpv4_type: 8' do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0800,
          ip_protocol: 1,
          icmpv4_type: 8
        )
      end
      Then { match.ether_type == 0x0800 }
      Then { match.ip_protocol == 1 }
      Then { match.icmpv4_type == 8 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 20 }
      And { match.match_fields.size == 3 }
      And do
        match.match_fields[2].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[2].oxm_field ==
          Pio::OpenFlow13::Match::Icmpv4Type::OXM_FIELD
      end
      And { match.match_fields[2].masked? == false }
      And { match.match_fields[2].oxm_length == 1 }
    end

    context 'with ether_type: 0x0800, ip_protocol: 1, icmpv4_code: 0' do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0800,
          ip_protocol: 1,
          icmpv4_code: 0
        )
      end
      Then { match.ether_type == 0x0800 }
      Then { match.ip_protocol == 1 }
      Then { match.icmpv4_code == 0 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 20 }
      And { match.match_fields.size == 3 }
      And do
        match.match_fields[2].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[2].oxm_field ==
          Pio::OpenFlow13::Match::Icmpv4Code::OXM_FIELD
      end
      And { match.match_fields[2].masked? == false }
      And { match.match_fields[2].oxm_length == 1 }
    end

    context 'with ether_type: 0x0806, arp_operation: 1' do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_operation: 1
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_operation == 1 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 16 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpOperation::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 2 }
    end

    context "with ether_type: 0x0806, arp_sender_protocol_address: '1.2.3.4'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_sender_protocol_address: '1.2.3.4'
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_sender_protocol_address == '1.2.3.4' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 18 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpSenderProtocolAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 4 }
    end

    context "with ether_type: 0x0806, arp_sender_protocol_address: '1.2.3.4', arp_sender_protocol_address_mask: '255.255.0.0'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_sender_protocol_address: '1.2.3.4',
          arp_sender_protocol_address_mask: '255.255.0.0'
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_sender_protocol_address == '1.2.3.4' }
      Then { match.arp_sender_protocol_address_mask == '255.255.0.0' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 22 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpSenderProtocolAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == true }
      And { match.match_fields[1].oxm_length == 8 }
    end

    context "with ether_type: 0x0806, arp_target_protocol_address: '1.2.3.4'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_target_protocol_address: '1.2.3.4'
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_target_protocol_address == '1.2.3.4' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 18 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpTargetProtocolAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 4 }
    end

    context "with ether_type: 0x0806, arp_target_protocol_address: '1.2.3.4', arp_target_protocol_address_mask: '255.255.0.0'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_target_protocol_address: '1.2.3.4',
          arp_target_protocol_address_mask: '255.255.0.0'
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_target_protocol_address == '1.2.3.4' }
      Then { match.arp_target_protocol_address_mask == '255.255.0.0' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 22 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpTargetProtocolAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == true }
      And { match.match_fields[1].oxm_length == 8 }
    end

    context "with ether_type: 0x0806, arp_sender_hardware_address: '11:22:33:44:55:66'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_sender_hardware_address: '11:22:33:44:55:66'
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_sender_hardware_address == '11:22:33:44:55:66' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 20 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpSenderHardwareAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 6 }
    end

    context "with ether_type: 0x0806, arp_sender_hardware_address: '11:22:33:44:55:66', arp_sender_hardware_address_mask: 'ff:ff:ff:00:00:00'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_sender_hardware_address: '11:22:33:44:55:66',
          arp_sender_hardware_address_mask: 'ff:ff:ff:00:00:00'
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_sender_hardware_address == '11:22:33:44:55:66' }
      Then { match.arp_sender_hardware_address_mask == 'ff:ff:ff:00:00:00' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 32 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 26 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpSenderHardwareAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == true }
      And { match.match_fields[1].oxm_length == 12 }
    end

    context "with ether_type: 0x0806, arp_target_hardware_address: '11:22:33:44:55:66'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_target_hardware_address: '11:22:33:44:55:66'
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_target_hardware_address == '11:22:33:44:55:66' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 20 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpTargetHardwareAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 6 }
    end

    context "with ether_type: 0x0806, arp_target_hardware_address: '11:22:33:44:55:66', arp_target_hardware_address_mask: 'ff:ff:ff:00:00:00'" do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          ether_type: 0x0806,
          arp_target_hardware_address: '11:22:33:44:55:66',
          arp_target_hardware_address_mask: 'ff:ff:ff:00:00:00'
        )
      end
      Then { match.ether_type == 0x0806 }
      Then { match.arp_target_hardware_address == '11:22:33:44:55:66' }
      Then { match.arp_target_hardware_address_mask == 'ff:ff:ff:00:00:00' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 32 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 26 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::ArpTargetHardwareAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == true }
      And { match.match_fields[1].oxm_length == 12 }
    end

    context 'with tunnel_id: 1' do
      When(:match) do
        Pio::OpenFlow13::Match.new(tunnel_id: 1)
      end
      Then { match.tunnel_id == 1 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 16 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::TunnelId::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 8 }
    end

    context 'with tunnel_id: 1, tunnel_id_mask: 0x8000000000000000' do
      When(:match) do
        Pio::OpenFlow13::Match.new(
          tunnel_id: 1,
          tunnel_id_mask: 0x8000000000000000
        )
      end
      Then { match.tunnel_id == 1 }
      Then { match.tunnel_id_mask == 0x8000000000000000 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 24 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::TunnelId::OXM_FIELD
      end
      And { match.match_fields[0].masked? == true }
      And { match.match_fields[0].oxm_length == 16 }
    end
  end

  def read_raw_data_file(name)
    IO.read File.join(__dir__, '..', '..', '..', name)
  end

  describe '.read' do
    When(:match) { Pio::OpenFlow13::Match.read(raw_data) }

    context 'with file "features/open_flow13/oxm_no_fields.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_no_fields.raw'
      end
      Then { match.match_fields == [] }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 8 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 4 }
    end

    context 'with file "features/open_flow13/oxm_in_port_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_in_port_field.raw'
      end
      Then { match.in_port == 1 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 12 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::InPort::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 4 }
    end

    context 'with file "features/open_flow13/oxm_ether_destination_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_ether_destination_field.raw'
      end
      Then { match.destination_mac_address == 'ff:ff:ff:ff:ff:ff' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 14 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::DestinationMacAddress::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 6 }
    end

    context 'with file "features/open_flow13/oxm_ether_source_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_ether_source_field.raw'
      end
      Then { match.source_mac_address == '01:02:03:04:05:06' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 14 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::SourceMacAddress::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 6 }
    end

    context 'with file "features/open_flow13/oxm_masked_ether_destination_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_masked_ether_destination_field.raw'
      end
      Then { match.destination_mac_address == 'ff:ff:ff:ff:ff:ff' }
      Then { match.destination_mac_address_mask == 'ff:ff:ff:00:00:00' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 20 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::DestinationMacAddress::OXM_FIELD
      end
      And { match.match_fields[0].masked? == true }
      And { match.match_fields[0].oxm_length == 12 }
    end

    context 'with file "features/open_flow13/oxm_masked_ether_source_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_masked_ether_source_field.raw'
      end
      Then { match.source_mac_address == '01:02:03:04:05:06' }
      Then { match.source_mac_address_mask == 'ff:ff:ff:00:00:00' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 20 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::SourceMacAddress::OXM_FIELD
      end
      And { match.match_fields[0].masked? == true }
      And { match.match_fields[0].oxm_length == 12 }
    end

    context 'with file "features/open_flow13/oxm_ether_type_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_ether_type_field.raw'
      end
      Then { match.ether_type == 0 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 10 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::EtherType::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with file "features/open_flow13/oxm_vlan_vid_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_vlan_vid_field.raw'
      end
      Then { match.vlan_vid == 10 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 10 }
      And { match.match_fields.size == 1 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::VlanVid::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with file "features/open_flow13/oxm_vlan_pcp_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_vlan_pcp_field.raw'
      end
      Then { match.vlan_pcp == 5 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 15 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::VlanVid::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with file "features/open_flow13/oxm_ip_dscp_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_ip_dscp_field.raw'
      end
      Then { match.ip_dscp == 0x2e }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 15 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::IpDscp::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with file "features/open_flow13/oxm_ip_ecn_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_ip_ecn_field.raw'
      end
      Then { match.ip_ecn == 3 }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 16 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 15 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::IpEcn::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
    end

    context 'with file "features/open_flow13/oxm_ipv4_source_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_ipv4_source_field.raw'
      end
      Then { match.ether_type == 0x0800 }
      Then { match.ipv4_source_address == '1.2.3.4' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 18 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::EtherType::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::Ipv4SourceAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 4 }
    end

    context 'with file "features/open_flow13/oxm_ipv4_destination_field.raw"' do
      Given(:raw_data) do
        read_raw_data_file 'features/open_flow13/oxm_ipv4_destination_field.raw'
      end
      Then { match.ether_type == 0x0800 }
      Then { match.ipv4_destination_address == '11.22.33.44' }
      And { match.class == Pio::OpenFlow13::Match }
      And { match.length == 24 }
      And { match.match_type == Pio::OpenFlow13::MATCH_TYPE_OXM }
      And { match.match_length == 18 }
      And { match.match_fields.size == 2 }
      And do
        match.match_fields[0].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[0].oxm_field ==
          Pio::OpenFlow13::Match::EtherType::OXM_FIELD
      end
      And { match.match_fields[0].masked? == false }
      And { match.match_fields[0].oxm_length == 2 }
      And do
        match.match_fields[1].oxm_class ==
          Pio::OpenFlow13::Match::OpenFlowBasicValue::OXM_CLASS
      end
      And do
        match.match_fields[1].oxm_field ==
          Pio::OpenFlow13::Match::Ipv4DestinationAddress::OXM_FIELD
      end
      And { match.match_fields[1].masked? == false }
      And { match.match_fields[1].oxm_length == 4 }
    end
  end
end
# rubocop:enable LineLength
