require 'pio'

describe Pio::ARP do
  Then { Pio::ARP == Pio::Arp }
end

describe Pio::Arp do
  describe '.read' do
    context 'with an Arp Request packet' do
      Given(:arp_request_dump) do
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
        ].pack('C*')
      end

      When(:arp_request) do
        Pio::Arp.read(arp_request_dump)
      end

      Then { arp_request.class == Pio::Arp::Request }
      Then { arp_request.destination_mac.to_s == 'ff:ff:ff:ff:ff:ff' }
      Then { arp_request.source_mac.to_s == '00:26:82:eb:ea:d1' }
      Then { arp_request.ether_type == 0x0806 }
      Then { arp_request.hardware_type == 1 }
      Then { arp_request.protocol_type == 0x0800 }
      Then { arp_request.hardware_length == 6 }
      Then { arp_request.protocol_length == 4 }
      Then { arp_request.operation == 1 }
      Then { arp_request.sender_hardware_address.to_s == '00:26:82:eb:ea:d1' }
      Then { arp_request.sender_protocol_address.to_s == '192.168.83.3' }
      Then { arp_request.target_hardware_address.to_s == '00:00:00:00:00:00' }
      Then { arp_request.target_protocol_address.to_s == '192.168.83.254' }
    end

    context 'with an Arp Reply packet' do
      Given(:arp_reply_dump) do
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
        ].pack('C*')
      end

      When(:arp_reply) do
        Pio::Arp.read(arp_reply_dump)
      end

      Then { arp_reply.class == Pio::Arp::Reply }
      Then { arp_reply.destination_mac.to_s == '00:26:82:eb:ea:d1' }
      Then { arp_reply.source_mac.to_s == '00:16:9d:1d:9c:c4' }
      Then { arp_reply.ether_type == 0x0806 }
      Then { arp_reply.hardware_type == 1 }
      Then { arp_reply.protocol_type == 0x0800 }
      Then { arp_reply.hardware_length == 6 }
      Then { arp_reply.protocol_length == 4 }
      Then { arp_reply.operation == 2 }
      Then { arp_reply.sender_hardware_address.to_s == '00:16:9d:1d:9c:c4' }
      Then { arp_reply.sender_protocol_address.to_s == '192.168.83.254' }
      Then { arp_reply.target_hardware_address.to_s == '00:26:82:eb:ea:d1' }
      Then { arp_reply.target_protocol_address.to_s == '192.168.83.3' }
    end

    context 'with an invalid ARP packet' do
      When(:result) do
        Pio::Arp.read('')
      end

      Then { result == Failure(Pio::ParseError, 'End of file reached') }
    end
  end
end
