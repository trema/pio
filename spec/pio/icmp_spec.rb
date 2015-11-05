require 'pio'

describe Pio::ICMP do
  Then { Pio::ICMP == Pio::Icmp }
end

describe Pio::Icmp, '.read' do
  context 'with an ICMP request frame' do
    Given(:icmp_request_dump) do
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
      ].pack('C*')
    end

    When(:icmp_request) do
      Pio::Icmp.read(icmp_request_dump)
    end

    Then { icmp_request.class == Pio::Icmp::Request }
    Then { icmp_request.destination_mac.to_s == '24:db:ac:41:e5:5b' }
    Then { icmp_request.source_mac.to_s == '00:26:82:eb:ea:d1' }
    Then { icmp_request.ether_type == 0x0800 }
    Then { icmp_request.ip_version == 0x4 }
    Then { icmp_request.ip_header_length == 0x5 }
    Then { icmp_request.ip_type_of_service == 0x0 }
    Then { icmp_request.ip_total_length == 60 }
    Then { icmp_request.ip_identifier == 0x39d3 }
    Then { icmp_request.ip_fragment == 0 }
    Then { icmp_request.ip_ttl == 128 }
    Then { icmp_request.ip_protocol == 1 }
    Then { icmp_request.ip_header_checksum == 0x2ed0 }
    Then { icmp_request.source_ip_address.to_s == '192.168.1.102' }
    Then { icmp_request.destination_ip_address.to_s == '8.8.8.8' }
    Then { icmp_request.icmp_type == 8 }
    Then { icmp_request.icmp_code == 0 }
    Then { icmp_request.icmp_checksum == 0x4c5b }
    Then { icmp_request.icmp_identifier == 0x0100 }
    Then { icmp_request.icmp_sequence_number == 0x0001 }
    Then { icmp_request.echo_data == 'abcdefghijklmnopqrstuvwabcdefghi' }
  end

  context 'with an ICMP reply frame' do
    Given(:icmp_reply_dump) do
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
      ].pack('C*')
    end

    When(:icmp_reply) do
      Pio::Icmp.read(icmp_reply_dump)
    end

    Then { icmp_reply.class == Pio::Icmp::Reply }
    Then { icmp_reply.destination_mac.to_s == '00:26:82:eb:ea:d1' }
    Then { icmp_reply.source_mac.to_s == '24:db:ac:41:e5:5b' }
    Then { icmp_reply.ether_type == 0x0800 }
    Then { icmp_reply.ip_version == 0x4 }
    Then { icmp_reply.ip_header_length == 0x5 }
    Then { icmp_reply.ip_type_of_service == 0 }
    Then { icmp_reply.ip_total_length == 60 }
    Then { icmp_reply.ip_identifier == 0 }
    Then { icmp_reply.ip_fragment == 0 }
    Then { icmp_reply.ip_ttl == 45 }
    Then { icmp_reply.ip_protocol == 1 }
    Then { icmp_reply.ip_header_checksum == 0xbba3 }
    Then { icmp_reply.source_ip_address.to_s == '8.8.8.8' }
    Then { icmp_reply.destination_ip_address.to_s == '192.168.1.102' }
    Then { icmp_reply.icmp_type == 0 }
    Then { icmp_reply.icmp_code == 0 }
    Then { icmp_reply.icmp_checksum == 0x545b }
    Then { icmp_reply.icmp_identifier == 0x0100 }
    Then { icmp_reply.icmp_sequence_number == 0x0001 }
    Then { icmp_reply.echo_data == 'abcdefghijklmnopqrstuvwabcdefghi' }
  end

  context 'with an invalid ICMP packet' do
    When(:result) do
      Pio::Icmp.read('')
    end

    Then { result == Failure(Pio::ParseError, 'End of file reached') }
  end
end
