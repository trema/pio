require 'pio'

describe Pio::ARP::Reply do
  Then { Pio::ARP::Reply == Pio::Arp::Reply }
end

describe Pio::Arp::Reply, '.new' do
  ARP_REPLY_DUMP =
    [
      0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # destination mac address
      0x00, 0x16, 0x9d, 0x1d, 0x9c, 0xc4, # source mac address
      0x08, 0x06,                         # ethernet type
      0x00, 0x01,                         # arp hardware type
      0x08, 0x00,                         # arp protocol type
      0x06,                               # hardware address size
      0x04,                               # protocol address size
      0x00, 0x02,                         # operational code
      0x00, 0x16, 0x9d, 0x1d, 0x9c, 0xc4, # sender hardware address
      0xc0, 0xa8, 0x53, 0xfe,             # sender protocol address
      0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # target hardware address
      0xc0, 0xa8, 0x53, 0x03,             # target protocol address
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, # padding
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00
    ].pack('C*')

  context 'with String MAC and IP address' do
    Given(:arp_reply) do
      Pio::Arp::Reply.new(
        source_mac: '00:16:9d:1d:9c:c4',
        destination_mac: '00:26:82:eb:ea:d1',
        sender_protocol_address: '192.168.83.254',
        target_protocol_address: '192.168.83.3'
      )
    end

    describe '#to_binary' do
      When(:result) { arp_reply.to_binary }

      Then { result == ARP_REPLY_DUMP }
      And { result.size == 64 }
    end
  end

  context 'with Integer MAC address and IP address' do
    Given(:arp_reply) do
      Pio::Arp::Reply.new(
        source_mac: 0x00169d1d9cc4,
        destination_mac: 0x002682ebead1,
        sender_protocol_address: 0xc0a853fe,
        target_protocol_address: 0xc0a85303
      )
    end

    describe '#to_binary' do
      When(:result) { arp_reply.to_binary }

      Then { result == ARP_REPLY_DUMP }
      And { result.size == 64 }
    end
  end

  context 'with String MAC and Integer IP address' do
    Given(:arp_reply) do
      Pio::Arp::Reply.new(
        source_mac: '00:16:9d:1d:9c:c4',
        destination_mac: '00:26:82:eb:ea:d1',
        sender_protocol_address: 0xc0a853fe,
        target_protocol_address: 0xc0a85303
      )
    end

    describe '#to_binary' do
      When(:result) { arp_reply.to_binary }

      Then { result == ARP_REPLY_DUMP }
      And { result.size == 64 }
    end
  end

  context 'with Integer MAC and String IP address' do
    Given(:arp_reply) do
      Pio::Arp::Reply.new(
        source_mac: 0x00169d1d9cc4,
        destination_mac: 0x002682ebead1,
        sender_protocol_address: '192.168.83.254',
        target_protocol_address: '192.168.83.3'
      )
    end

    describe '#to_binary' do
      When(:result) { arp_reply.to_binary }

      Then { result == ARP_REPLY_DUMP }
      And { result.size == 64 }
    end
  end
end
