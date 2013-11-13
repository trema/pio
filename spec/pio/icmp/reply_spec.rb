# -*- coding: utf-8 -*-
require 'pio/icmp/reply'

describe Pio::Icmp::Reply do
  context '.new' do
    subject do
      Pio::Icmp::Reply.new(
        :source_mac => source_mac,
        :destination_mac => destination_mac,
        :ip_source_address => ip_source_address,
        :ip_destination_address => ip_destination_address,
        :icmp_identifier => icmp_identifier,
        :icmp_sequence_number => icmp_sequence_number,
        :echo_data => echo_data
      )
    end

    context 'with :echo_data' do
      let(:icmp_reply_dump) do
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
          0x80,
          # IP Protocol
          0x01,
          # IP Header Checksum
          0x68, 0xa3,
          # IP Source Address
          0x08, 0x08, 0x08, 0x08,
          # IP Destination Address
          0xc0, 0xa8, 0x01, 0x66,
          # ICMP Type
          0x00,
          # ICMP Code
          0x00,
          # ICMP Checksum
          0x45, 0x5b,
          # ICMP Identifier
          0x10, 0x00,
          # ICMP Sequence Number
          0x00, 0x01,
          # Echo Data
          0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
          0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e,
          0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75,
          0x76, 0x77, 0x61, 0x62, 0x63, 0x64, 0x65,
          0x66, 0x67, 0x68, 0x69
        ]
      end

      let(:source_mac) { '24:db:ac:41:e5:5b' }
      let(:destination_mac) { '00:26:82:eb:ea:d1' }
      let(:ip_source_address) { '8.8.8.8' }
      let(:ip_destination_address) { '192.168.1.102' }
      let(:icmp_identifier) { 0x1000 }
      let(:icmp_sequence_number) { 0x0001 }
      let(:echo_data) { 'abcdefghijklmnopqrstuvwabcdefghi' }

      context '#to_binary' do
        it 'returns an ICMP reply binary string' do
          expect(subject.to_binary.unpack('C*')).to eq icmp_reply_dump
        end
      end
    end

    context 'with an emply :echo_data' do
      let(:icmp_reply_dump) do
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
          0x00, 0x32,
          # IP Identifier
          0x00, 0x00,
          # IP Flag&IP Fragment
          0x00, 0x00,
          # IP TTL
          0x80,
          # IP Protocol
          0x01,
          # IP Header Checksum
          0x68, 0xad,
          # IP Source Address
          0x08, 0x08, 0x08, 0x08,
          # IP Destination Address
          0xc0, 0xa8, 0x01, 0x66,
          # ICMP Type
          0x00,
          # ICMP Code
          0x00,
          # ICMP Checksum
          0xef, 0xfe,
          # ICMP Identifier
          0x10, 0x00,
          # ICMP Sequence Number
          0x00, 0x01,
          # Echo Data
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00
        ]
      end

      let(:source_mac) { '24:db:ac:41:e5:5b' }
      let(:destination_mac) { '00:26:82:eb:ea:d1' }
      let(:ip_source_address) { '8.8.8.8' }
      let(:ip_destination_address) { '192.168.1.102' }
      let(:icmp_identifier) { 0x1000 }
      let(:icmp_sequence_number) { 0x0001 }
      let(:echo_data) { '' }

      context '#to_binary' do
        it 'returns an ICMP reply binary string' do
          expect(subject.to_binary.unpack('C*')).to eq icmp_reply_dump
        end
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
