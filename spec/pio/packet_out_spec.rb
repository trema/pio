require 'pio/packet_out'

describe Pio::PacketOut do
  Given(:header_dump) do
    [
      0x01,
      0x0d,
      0x00, 0x58,
      0x00, 0x00, 0x00, 0x16
    ].pack('C*')
  end

  Given(:data_dump) do
    [
      0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e, 0x01, 0x02, 0x03, 0x04,
      0x05, 0x06, 0x88, 0xcc, 0x02, 0x09, 0x07, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x01, 0x23, 0x04, 0x05, 0x07, 0x00, 0x00,
      0x00, 0x0c, 0x06, 0x02, 0x00, 0x78, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00
    ].pack('C*')
  end

  Given(:body_dump) do
    [
      0xff, 0xff, 0xff, 0xff,
      0xff, 0xff,
      0x00, 0x08,
      0x00, 0x00, 0x00, 0x08, 0x00, 0x02, 0xff, 0xff
    ].pack('C*') + data_dump
  end

  Given(:packet_out_dump) { header_dump + body_dump }

  describe '.read' do
    context 'with a Packet-Out message' do
      When(:packet_out) do
        Pio::PacketOut.read(packet_out_dump)
      end

      Then { packet_out.class == Pio::PacketOut }
      Then { packet_out.ofp_version == 0x1 }
      Then { packet_out.message_type == 0xd }
      Then { packet_out.message_length == 0x58 }
      Then { packet_out.transaction_id == 0x16 }
      Then { packet_out.xid == 0x16 }

      Then { !packet_out.body.empty? }
      Then { packet_out.buffer_id == 0xffffffff }
      Then { packet_out.in_port == 0xffff }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SendOutPort }
      Then { packet_out.actions[0].port_number == 2 }
      Then { packet_out.actions[0].max_len == 2**16 - 1 }
      Then { packet_out.data.length == 64 }
    end
  end

  describe '.new' do
    context 'with a SendOutPort action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SendOutPort.new(2),
                           data: data_dump)
      end

      Then { packet_out.ofp_version == 0x1 }
      Then { packet_out.message_type == 0xd }
      Then { packet_out.message_length == 0x58 }
      Then { packet_out.transaction_id == 0x16 }
      Then { packet_out.xid == 0x16 }

      Then { !packet_out.body.empty? }
      Then { packet_out.buffer_id == 0xffffffff }
      Then { packet_out.in_port == 0xffff }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SendOutPort }
      Then { packet_out.actions[0].port_number == 2 }
      Then { packet_out.actions[0].max_len == 2**16 - 1 }
      Then { packet_out.data.length == 64 }

      context '#to_binary' do
        When(:binary) { packet_out.to_binary }
        Then { binary == packet_out_dump }
      end
    end

    context 'with a SetVlanVid action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetVlanVid.new(10),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x58 }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetVlanVid }
      Then { packet_out.actions[0].vlan_id == 10 }
    end

    context 'with a SetVlanPriority action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetVlanPriority.new(3),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x58 }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetVlanPriority }
      Then { packet_out.actions[0].vlan_priority == 3 }
    end

    context 'with a StripVlanHeader action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::StripVlanHeader.new,
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x58 }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::StripVlanHeader }
    end

    context 'with a SetEthSrcAddr action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetEthSrcAddr.new('11:22:33:44:55:66'),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x60 }
      Then { packet_out.actions_len == 0x10 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetEthSrcAddr }
      Then { packet_out.actions[0].mac_address == '11:22:33:44:55:66' }
    end

    context 'with a SetEthDstAddr action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetEthDstAddr.new('11:22:33:44:55:66'),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x60 }
      Then { packet_out.actions_len == 0x10 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetEthDstAddr }
      Then { packet_out.actions[0].mac_address == '11:22:33:44:55:66' }
    end

    context 'with a SetIpSrcAddr action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetIpSrcAddr.new('1.2.3.4'),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x58 }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetIpSrcAddr }
      Then { packet_out.actions[0].ip_address == '1.2.3.4' }
    end

    context 'with a SetIpDstAddr action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetIpDstAddr.new('1.2.3.4'),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x58 }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetIpDstAddr }
      Then { packet_out.actions[0].ip_address == '1.2.3.4' }
    end

    context 'with a SetIpTos action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetIpTos.new(32),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x58 }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetIpTos }
      Then { packet_out.actions[0].type_of_service == 32 }
    end

    context 'with a SetTransportSrcPort action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetTransportSrcPort.new(100),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x58 }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetTransportSrcPort }
      Then { packet_out.actions[0].port_number == 100 }
    end

    context 'with a SetTransportDstPort action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::SetTransportDstPort.new(100),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x58 }
      Then { packet_out.actions_len == 0x8 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::SetTransportDstPort }
      Then { packet_out.actions[0].port_number == 100 }
    end

    context 'with a Enqueue action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: Pio::Enqueue.new(port_number: 1,
                                                     queue_id: 2),
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x60 }
      Then { packet_out.actions_len == 0x10 }
      Then { packet_out.actions.length == 1 }
      Then { packet_out.actions[0].is_a? Pio::Enqueue }
      Then { packet_out.actions[0].port_number == 1 }
      Then { packet_out.actions[0].queue_id == 2 }
    end

    context 'with SendOutPort and SetVlanVid action' do
      Given(:packet_out) do
        Pio::PacketOut.new(transaction_id: 0x16,
                           buffer_id: 0xffffffff,
                           in_port: 0xffff,
                           actions: [Pio::SendOutPort.new(2),
                                     Pio::SetVlanVid.new(10)],
                           data: data_dump)
      end

      Then { packet_out.message_length == 0x60 }
      Then { packet_out.actions_len == 0x10 }
      Then { packet_out.actions.length == 2 }
      Then { packet_out.actions[0].is_a? Pio::SendOutPort }
      Then { packet_out.actions[0].port_number == 2 }
      Then { packet_out.actions[0].max_len == 2**16 - 1 }
      Then { packet_out.actions[1].is_a? Pio::SetVlanVid }
      Then { packet_out.actions[1].vlan_id == 10 }
    end
  end
end
