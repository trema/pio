require 'pio'

describe Pio::ICMP::Request do
  Then { Pio::ICMP::Request == Pio::Icmp::Request }
end

describe Pio::Icmp do
  Given(:icmp_request) do
    Pio::Icmp::Request.new(
      destination_mac: '24:db:ac:41:e5:5b',
      source_mac: '74:e5:0b:2a:18:f8',
      source_ip_address: '192.168.1.101',
      destination_ip_address: '8.8.8.8',
      identifier: 0x123,
      sequence_number: 0x321,
      echo_data: 'abcdefghijklmnopqrstuvwabcdefghi'
    ).to_binary
  end

  describe '.read' do
    When(:result) { Pio::Icmp.read icmp_request }
    Then { result.echo_data == 'abcdefghijklmnopqrstuvwabcdefghi' }
  end
end

describe Pio::Icmp::Request, '.new' do
  context 'with echo_data' do
    Given(:icmp_request) do
      Pio::Icmp::Request.new(
        destination_mac: '24:db:ac:41:e5:5b',
        source_mac: '74:e5:0b:2a:18:f8',
        source_ip_address: '192.168.1.101',
        destination_ip_address: '8.8.8.8',
        identifier: 0x123,
        sequence_number: 0x321,
        echo_data: 'abcdefghijklmnopqrstuvwabcdefghi'
      )
    end

    describe '#to_binary' do
      When(:result) { icmp_request.to_binary }

      Then do
        result.unpack('C*') ==
          [
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
            0x49, 0x18,
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
          ]
      end
    end
  end

  context 'with empty echo_data' do
    Given(:icmp_request) do
      Pio::Icmp::Request.new(
        destination_mac: '24:db:ac:41:e5:5b',
        source_mac: '74:e5:0b:2a:18:f8',
        source_ip_address: '192.168.1.101',
        destination_ip_address: '8.8.8.8',
        identifier: 0x123,
        sequence_number: 0x321
      )
    end

    describe '#to_binary' do
      When(:result) { icmp_request.to_binary }

      Then do
        result.unpack('C*') ==
          [
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
            0xf3, 0xbb,
            # ICMP Identifier
            0x01, 0x23,
            # ICMP Sequence Number
            0x03, 0x21,
            # Echo Data
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00
          ]
      end
    end
  end
end
