# -*- coding: utf-8 -*-
require 'pio/icmp/request'

describe Pio::Icmp::Request do
  context '.new' do
    subject do
      Pio::Icmp::Request.new(
        destination_mac: '24:db:ac:41:e5:5b',
        source_mac: '74:e5:0b:2a:18:f8',
        ip_source_address: '192.168.1.101',
        ip_destination_address: '8.8.8.8',
        echo_data: echo_data
      )
    end

    context 'with :echo_data' do
      let(:echo_data) { 'abcdefghijklmnopqrstuvwabcdefghi' }

      context '#to_binary' do
        it 'returns an ICMP request binary string' do
          valid_icmp_request_dump =  [
            # Destination MAC
            0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
            # Source MAC
            0x74, 0xe5, 0x0b, 0x2a, 0x18, 0xf8,
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
            0x68, 0xa4,
            # IP Source Address
            0xc0, 0xa8, 0x01, 0x65,
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
            0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
            0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e,
            0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75,
            0x76, 0x77, 0x61, 0x62, 0x63, 0x64, 0x65,
            0x66, 0x67, 0x68, 0x69
          ]

          expect(subject.to_binary.unpack('C*')).to eq valid_icmp_request_dump
        end
      end
    end

    context 'with an emply :echo_data' do
      let(:echo_data) { '' }

      context '#to_binary' do
        it 'returns an ICMP request binary string' do
          valid_icmp_request_dump = [
            # Destination MAC
            0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
            # Source MAC
            0x74, 0xe5, 0x0b, 0x2a, 0x18, 0xf8,
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
            0x68, 0xae,
            # IP Source Address
            0xc0, 0xa8, 0x01, 0x65,
            # IP Destination Address
            0x08, 0x08, 0x08, 0x08,
            # ICMP Type
            0x08,
            # ICMP Code
            0x00,
            # ICMP Checksum
            0xf6, 0xfe,
            # ICMP Identifier
            0x01, 0x00,
            # ICMP Sequence Number
            0x00, 0x01,
            # Echo Data
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00
          ]

          expect(subject.to_binary.unpack('C*')).to eq valid_icmp_request_dump
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
