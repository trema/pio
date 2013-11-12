# -*- coding: utf-8 -*-
require 'pio'

describe Pio::Icmp do
  context '.read' do
    subject { Pio::Icmp.read(data.pack('C*')) }

    context 'With ICMP Request Frame' do
      let(:data) do
        [
          # Destination MAC
          0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
          # Source MAC
          0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1,
          # EtherType
          0x08, 0x00,
          # IP Version&IP Header Length
          0x45,
          # IP Type Of Service
          0x00,
          # IP Total Length
          0x00, 0x3c,
          # IP Identifier
          0x39, 0xd3,
          # IP Flag&IP Fragment
          0x00, 0x00,
          # IP TTL
          0x80,
          # IP Protocol
          0x01,
          # IP Header Checksum
          0x2e, 0xd0,
          # IP Source Address
          0xc0, 0xa8, 0x01, 0x66,
          # IP Destination Address
          0x08, 0x08, 0x08, 0x08,
          # ICMP Type
          0x08,
          # ICMP Code
          0x00,
          # ICMP Checksum
          0x4c, 0x5b,
          # ICMP Identifier
          0x01, 0x00,
          # ICMP Sequence Number
          0x00, 0x01,
          # Echo Data
          0x61, 0x62, 0x63, 0x64, 0x65, 0x66,
          0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c,
          0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72,
          0x73, 0x74, 0x75, 0x76, 0x77, 0x61,
          0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
          0x68, 0x69
        ]
      end

      its('destination_mac.to_s') { should eq '24:db:ac:41:e5:5b' }
      its('source_mac.to_s') { should eq '00:26:82:eb:ea:d1' }
      its(:ether_type) { should eq 0x0800 }
      its(:ip_version) { should eq 0x4 }
      its(:ip_header_length) { should eq 0x5 }
      its(:ip_type_of_service) { should eq 0x0 }
      its(:ip_total_length) { should eq 60 }
      its(:ip_identifier) { should eq 0x39d3 }
      its(:ip_fragment) { should eq 0 }
      its(:ip_ttl) { should eq 128 }
      its(:ip_protocol) { should eq 1 }
      its(:ip_header_checksum) { should eq 0x2ed0 }
      its('ip_source_address.to_s') { should eq '192.168.1.102' }
      its('ip_destination_address.to_s') { should eq '8.8.8.8' }
      its(:icmp_type) { should eq 8 }
      its(:icmp_code) { should eq 0 }
      its(:icmp_checksum) { should eq 0x4c5b }
      its(:icmp_identifier) { should eq 0x0100 }
      its(:icmp_sequence_number) { should eq 0x0001 }
      its(:echo_data) { should eq 'abcdefghijklmnopqrstuvwabcdefghi' }
    end

    context 'With ICMP Reply Frame' do
      let(:data) do
        [
          # Destination MAC
          0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1,
          # Source MAC
          0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
          # EtherType
          0x08, 0x00,
          # IP Version&IP Header Length
          0x45,
          # IP Type Of Service
          0x00,
          # IP Total Length
          0x00, 0x3c,
          # IP Identifier
          0x00, 0x00,
          # IP Flag&IP Fragment
          0x00, 0x00,
          # IP TTL
          0x2d,
          # IP Protocol
          0x01,
          # IP Header Checksum
          0xbb, 0xa3,
          # IP Source Address
          0x08, 0x08, 0x08, 0x08,
          # IP Destination Address
          0xc0, 0xa8, 0x01, 0x66,
          # ICMP Type
          0x00,
          # ICMP Code
          0x00,
          # ICMP Checksum
          0x54, 0x5b,
          # ICMP Identifier
          0x01, 0x00,
          # ICMP Sequence Number
          0x00, 0x01,
          0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a,
          0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74,
          0x75, 0x76, 0x77, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
          0x68, 0x69
        ]
      end

      its('destination_mac.to_s') { should eq '00:26:82:eb:ea:d1' }
      its('source_mac.to_s') { should eq '24:db:ac:41:e5:5b' }
      its(:ether_type) { should eq 0x0800 }
      its(:ip_version) { should eq 0x4 }
      its(:ip_header_length) { should eq 0x5 }
      its(:ip_type_of_service) { should eq 0 }
      its(:ip_total_length) { should eq 60 }
      its(:ip_identifier) { should eq 0 }
      its(:ip_fragment) { should eq 0 }
      its(:ip_ttl) { should eq 45 }
      its(:ip_protocol) { should eq 1 }
      its(:ip_header_checksum) { should eq 0xbba3 }
      its('ip_source_address.to_s') { should eq '8.8.8.8' }
      its('ip_destination_address.to_s') { should eq '192.168.1.102' }
      its(:icmp_type) { should eq 0 }
      its(:icmp_code) { should eq 0 }
      its(:icmp_checksum) { should eq 0x545b }
      its(:icmp_identifier) { should eq 0x0100 }
      its(:icmp_sequence_number) { should eq 0x0001 }
      its(:echo_data) { should eq 'abcdefghijklmnopqrstuvwabcdefghi' }
    end

    context 'With An Invalid Icmp Frame' do
      let(:data) { [] }

      it { expect { subject }.to raise_error(Pio::ParseError) }
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
