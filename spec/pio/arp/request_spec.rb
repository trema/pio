# -*- coding: utf-8 -*-
require 'pio/arp/request'

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

  context 'when source_mac is not passed' do
    When(:result) do
      Pio::Arp::Request.new(
        sender_protocol_address: '192.168.83.3',
        target_protocol_address: '192.168.83.254'
      )
    end

    Then do
      result ==
        Failure(ArgumentError, 'The source_mac option should be passed.')
    end
  end

  context 'with source_mac = nil' do
    When(:result) do
      Pio::Arp::Request.new(
        source_mac: nil,
        sender_protocol_address: '192.168.83.3',
        target_protocol_address: '192.168.83.254'
      )
    end

    Then do
      result ==
        Failure(ArgumentError, "The source_mac option shouldn't be nil.")
    end
  end

  context 'when sender_protocol_address is not passed' do
    When(:result) do
      Pio::Arp::Request.new(
        source_mac: 0x002682ebead1,
        target_protocol_address: '192.168.83.254'
      )
    end

    Then do
      result == Failure(ArgumentError,
                        'The sender_protocol_address option should be passed.')
    end
  end

  context 'with sender_protocol_address = nil' do
    When(:result) do
      Pio::Arp::Request.new(
        source_mac: 0x002682ebead1,
        sender_protocol_address: nil,
        target_protocol_address: '192.168.83.254'
      )
    end

    Then do
      result == Failure(ArgumentError,
                        "The sender_protocol_address option shouldn't be nil.")
    end
  end

  context 'when :target_protocol_address is not passed' do
    When(:result) do
      Pio::Arp::Request.new(
        source_mac: 0x002682ebead1,
        sender_protocol_address: '192.168.83.254'
      )
    end

    Then do
      result == Failure(ArgumentError,
                        'The target_protocol_address option should be passed.')
    end
  end

  context 'when :target_protocol_address = nil' do
    When(:result) do
      Pio::Arp::Request.new(
        source_mac: 0x002682ebead1,
        sender_protocol_address: '192.168.83.254',
        target_protocol_address: nil
      )
    end

    Then do
      result == Failure(ArgumentError,
                        "The target_protocol_address option shouldn't be nil.")
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
