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

  describe '.read' do
    When(:result) { Pio::PacketOut.read(binary) }

    context 'with a Packet-Out message' do
      When(:binary) { header_dump + body_dump }

      Then { result.class == Pio::PacketOut }
      Then { result.ofp_version == 0x1 }
      Then { result.message_type == 0xd }
      Then { result.message_length == 0x58 }
      Then { result.transaction_id == 0x16 }
      Then { result.xid == 0x16 }

      Then { !result.body.empty? }
      Then { result.buffer_id == 0xffffffff }
      Then { result.in_port == 0xffff }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SendOutPort }
      Then { result.actions[0].port_number == 2 }
      Then { result.actions[0].max_len == 2**16 - 1 }
      Then { result.raw_data.length == 64 }
    end

    context 'with a Packet-Out message generated with PacketOut.new' do
      When(:binary) do
        Pio::PacketOut.new(
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SendOutPort.new(2),
          raw_data: data_dump
        ).to_binary
      end

      Then { result.class == Pio::PacketOut }
      Then { result.ofp_version == 0x1 }
      Then { result.message_type == 0xd }
      Then { result.message_length == 0x58 }
      Then { result.transaction_id == 0x16 }
      Then { result.xid == 0x16 }

      Then { !result.body.empty? }
      Then { result.buffer_id == 0xffffffff }
      Then { result.in_port == 0xffff }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SendOutPort }
      Then { result.actions[0].port_number == 2 }
      Then { result.actions[0].max_len == 2**16 - 1 }
      Then { result.raw_data.length == 64 }
    end

    context 'with a Hello message' do
      When(:binary) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then do
        result == Failure(Pio::ParseError,
                          'Invalid PacketOut message.')
      end
    end
  end

  describe '.new' do
    When(:result) { Pio::PacketOut.new(user_options) }

    context 'with a SendOutPort action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SendOutPort.new(2),
          raw_data: data_dump
        }
      end

      Then { result.ofp_version == 0x1 }
      Then { result.message_type == 0xd }
      Then { result.message_length == 0x58 }
      Then { result.transaction_id == 0x16 }
      Then { result.xid == 0x16 }

      Then { !result.body.empty? }
      Then { result.buffer_id == 0xffffffff }
      Then { result.in_port == 0xffff }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SendOutPort }
      Then { result.actions[0].port_number == 2 }
      Then { result.actions[0].max_len == 2**16 - 1 }
      Then { result.raw_data.length == 64 }

      context '#to_binary' do
        When(:binary) { result.to_binary }

        Then { binary == header_dump + body_dump }
      end
    end

    context 'with a SetVlanVid action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetVlanVid.new(10),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetVlanVid }
      Then { result.actions[0].vlan_id == 10 }
    end

    context 'with a SetVlanPriority action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetVlanPriority.new(3),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetVlanPriority }
      Then { result.actions[0].vlan_priority == 3 }
    end

    context 'with a StripVlanHeader action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::StripVlanHeader.new,
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::StripVlanHeader }
    end

    context 'with a SetEtherSourceAddr action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetEtherSourceAddr.new('11:22:33:44:55:66'),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x60 }
      Then { result.actions_len == 0x10 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetEtherSourceAddr }
      Then { result.actions[0].mac_address == '11:22:33:44:55:66' }
    end

    context 'with a SetEtherDstAddr action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetEtherDstAddr.new('11:22:33:44:55:66'),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x60 }
      Then { result.actions_len == 0x10 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetEtherDstAddr }
      Then { result.actions[0].mac_address == '11:22:33:44:55:66' }
    end

    context 'with a SetIpSourceAddr action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetIpSourceAddr.new('1.2.3.4'),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetIpSourceAddr }
      Then { result.actions[0].ip_address == '1.2.3.4' }
    end

    context 'with a SetIpDstAddr action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetIpDstAddr.new('1.2.3.4'),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetIpDstAddr }
      Then { result.actions[0].ip_address == '1.2.3.4' }
    end

    context 'with a SetIpTos action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetIpTos.new(32),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetIpTos }
      Then { result.actions[0].type_of_service == 32 }
    end

    context 'with a SetTransportSourcePort action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetTransportSourcePort.new(100),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetTransportSourcePort }
      Then { result.actions[0].port_number == 100 }
    end

    context 'with a SetTransportDstPort action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::SetTransportDstPort.new(100),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::SetTransportDstPort }
      Then { result.actions[0].port_number == 100 }
    end

    context 'with a Enqueue action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::Enqueue.new(port_number: 1, queue_id: 2),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x60 }
      Then { result.actions_len == 0x10 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::Enqueue }
      Then { result.actions[0].port_number == 1 }
      Then { result.actions[0].queue_id == 2 }
    end

    context 'with SendOutPort and SetVlanVid action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: [Pio::SendOutPort.new(2), Pio::SetVlanVid.new(10)],
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x60 }
      Then { result.actions_len == 0x10 }
      Then { result.actions.length == 2 }
      Then { result.actions[0].is_a? Pio::SendOutPort }
      Then { result.actions[0].port_number == 2 }
      Then { result.actions[0].max_len == 2**16 - 1 }
      Then { result.actions[1].is_a? Pio::SetVlanVid }
      Then { result.actions[1].vlan_id == 10 }
    end
  end
end
