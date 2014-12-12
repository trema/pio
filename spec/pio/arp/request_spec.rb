require 'pio'

describe Pio::ARP::Request do
  Then { Pio::ARP::Request == Pio::Arp::Request }
end

describe Pio::Arp::Request, '.new' do
  ARP_REQUEST_DUMP =
    [
      0xff, 0xff, 0xff, 0xff, 0xff, 0xff, # destination mac address
      0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # source mac address
      0x08, 0x06,                         # ethernet type
      0x00, 0x01,                         # arp hardware type
      0x08, 0x00,                         # arp protocol type
      0x06,                               # hardware address size
      0x04,                               # protocol address size
      0x00, 0x01,                         # operational code
      0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # sender hardware address
      0xc0, 0xa8, 0x53, 0x03,             # sender protocol address
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, # target hardware address
      0xc0, 0xa8, 0x53, 0xfe,             # target protocol address
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, # padding
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00
    ].pack('C*')

  context 'with String MAC and IP address' do
    Given(:arp_request) do
      Pio::Arp::Request.new(
        source_mac: '00:26:82:eb:ea:d1',
        sender_protocol_address: '192.168.83.3',
        target_protocol_address: '192.168.83.254'
      )
    end

    describe '#to_binary' do
      When(:result) { arp_request.to_binary }

      Then { result == ARP_REQUEST_DUMP }
      And { result.size == 64 }
    end
  end

  context 'with Integer MAC address and IP address' do
    Given(:arp_request) do
      Pio::Arp::Request.new(
        source_mac: 0x002682ebead1,
        sender_protocol_address: 0xc0a85303,
        target_protocol_address: 0xc0a853fe
      )
    end

    describe '#to_binary' do
      When(:result) { arp_request.to_binary }

      Then { result == ARP_REQUEST_DUMP }
      And { result.size == 64 }
    end
  end

  context 'with String MAC and Integer IP address' do
    Given(:arp_request) do
      Pio::Arp::Request.new(
        source_mac: '00:26:82:eb:ea:d1',
        sender_protocol_address: 0xc0a85303,
        target_protocol_address: 0xc0a853fe
      )
    end

    describe '#to_binary' do
      When(:result) { arp_request.to_binary }

      Then { result == ARP_REQUEST_DUMP }
      And { result.size == 64 }
    end
  end

  context 'with Integer MAC and String IP address' do
    Given(:arp_request) do
      Pio::Arp::Request.new(
        source_mac: 0x002682ebead1,
        sender_protocol_address: '192.168.83.3',
        target_protocol_address: '192.168.83.254'
      )
    end

    describe '#to_binary' do
      When(:result) { arp_request.to_binary }

      Then { result == ARP_REQUEST_DUMP }
      And { result.size == 64 }
    end
  end
end
