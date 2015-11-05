require 'pio'

describe Pio::ICMP::Reply do
  Then { Pio::ICMP::Reply == Pio::Icmp::Reply }
end

describe Pio::Icmp::Reply, '.new' do
  context 'with echo_data' do
    Given(:icmp_reply) do
      Pio::Icmp::Reply.new(
        destination_mac: '00:26:82:eb:ea:d1',
        source_mac: '24:db:ac:41:e5:5b',
        source_ip_address: '8.8.8.8',
        destination_ip_address: '192.168.1.102',
        identifier: 0x123,
        sequence_number: 0x321,
        echo_data: 'abcdefghijklmnopqrstuvwabcdefghi'
      )
    end

    describe '#to_binary' do
      When(:result) { icmp_reply.to_binary }

      Then do
        result ==
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
            0x51, 0x18,
            # ICMP Identifier
            0x01, 0x23,
            # ICMP Sequence Number
            0x03, 0x21,
            # Echo Data
            0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
            0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e,
            0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75,
            0x76, 0x77, 0x61, 0x62, 0x63, 0x64, 0x65,
            0x66, 0x67, 0x68, 0x69
          ].pack('C*')
      end
    end

    context 'with an empty :echo_data' do
      Given(:icmp_reply) do
        Pio::Icmp::Reply.new(
          destination_mac: '00:26:82:eb:ea:d1',
          source_mac: '24:db:ac:41:e5:5b',
          source_ip_address: '8.8.8.8',
          destination_ip_address: '192.168.1.102',
          identifier: 0x123,
          sequence_number: 0x321
        )
      end

      describe '#to_binary' do
        When(:result) { icmp_reply.to_binary }

        Then do
          result ==
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
              0xfb, 0xbb,
              # ICMP Identifier
              0x01, 0x23,
              # ICMP Sequence Number
              0x03, 0x21,
              # Echo Data
              0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
              0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
              0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
              0x00, 0x00, 0x00, 0x00
            ].pack('C*')
        end
      end
    end
  end
end
