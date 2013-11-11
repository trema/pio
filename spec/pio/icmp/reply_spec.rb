# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')
require 'pio/icmp/reply'

# ICMP Reply Generate Test.
module Pio
  # Class ICMP.
  class Icmp
    describe Reply do
      context '.new' do
        subject do
          Icmp::Reply.new(
            :source_mac => source_mac,
            :destination_mac => destination_mac,
            :ip_ttl => ip_ttl,
            :ip_source_address => ip_source_address,
            :ip_destination_address => ip_destination_address,
            :echo_data => echo_data,
            :icmp_identifier => icmp_identifier,
            :icmp_sequence_number => icmp_sequence_number
          )
        end

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

        context 'Give ICMP Reply options be equvalent to raw data' do
          let(:source_mac) { '24:db:ac:41:e5:5b' }
          let(:destination_mac) { '00:26:82:eb:ea:d1' }
          let(:ip_ttl) { 0x2d }
          let(:ip_source_address) { '8.8.8.8' }
          let(:ip_destination_address) { '192.168.1.102' }
          let(:icmp_identifier) { 0x1000 }
          let(:icmp_sequence_number) { 0x0001 }
          let(:echo_data) { 'abcdefghijklmnopqrstuvwabcdefghi' }

          its(:to_binary) { should eq icmp_reply_dump.pack('C*') }
        end

        context 'Give ICMP Reply minimal icmp data length' do
          let(:source_mac) { '24:db:ac:41:e5:5b' }
          let(:destination_mac) { '00:26:82:eb:ea:d1' }
          let(:ip_ttl) { 0x2d }
          let(:ip_source_address) { '8.8.8.8' }
          let(:ip_destination_address) { '192.168.1.102' }
          let(:icmp_identifier) { 0x1000 }
          let(:icmp_sequence_number) { 0x0001 }
          let(:echo_data) { '' }

          its('to_binary.length') { should eq 64 }
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
