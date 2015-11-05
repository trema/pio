require 'pio/open_flow10/packet_out'
require 'pio/parse_error'

# rubocop:disable LineLength
describe Pio::OpenFlow10::PacketOut do
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
    When(:result) { Pio::OpenFlow10::PacketOut.read(binary) }

    context 'with a Packet-Out message' do
      When(:binary) { header_dump + body_dump }

      Then { result.class == Pio::OpenFlow10::PacketOut }
      Then { result.ofp_version == 0x1 }
      Then { result.message_type == 0xd }
      Then { result.message_length == 0x58 }
      Then { result.transaction_id == 0x16 }
      Then { result.xid == 0x16 }

      Then { result.buffer_id == 0xffffffff }
      Then { result.in_port == 0xffff }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SendOutPort }
      Then { result.actions[0].port == 2 }
      Then { result.actions[0].max_length == 2**16 - 1 }
      Then { result.raw_data.length == 64 }
    end

    context 'with a Packet-Out message generated with PacketOut.new' do
      When(:binary) do
        Pio::OpenFlow10::PacketOut.new(
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SendOutPort.new(2),
          raw_data: data_dump
        ).to_binary
      end

      Then { result.class == Pio::OpenFlow10::PacketOut }
      Then { result.ofp_version == 0x1 }
      Then { result.message_type == 0xd }
      Then { result.message_length == 0x58 }
      Then { result.transaction_id == 0x16 }
      Then { result.xid == 0x16 }

      Then { result.buffer_id == 0xffffffff }
      Then { result.in_port == 0xffff }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SendOutPort }
      Then { result.actions[0].port == 2 }
      Then { result.actions[0].max_length == 2**16 - 1 }
      Then { result.raw_data.length == 64 }
    end

    context 'with a Hello message' do
      When(:binary) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then do
        result == Failure(Pio::ParseError,
                          'Invalid OpenFlow10 PacketOut message.')
      end
    end
  end

  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow10::PacketOut)

    When(:result) { Pio::OpenFlow10::PacketOut.new(user_options) }

    context 'with a SendOutPort action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SendOutPort.new(2),
          raw_data: data_dump
        }
      end

      Then { result.ofp_version == 0x1 }
      Then { result.message_type == 0xd }
      Then { result.message_length == 0x58 }
      Then { result.transaction_id == 0x16 }
      Then { result.xid == 0x16 }

      Then { result.buffer_id == 0xffffffff }
      Then { result.in_port == 0xffff }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SendOutPort }
      Then { result.actions[0].port == 2 }
      Then { result.actions[0].max_length == 2**16 - 1 }
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
          actions: Pio::OpenFlow10::SetVlanVid.new(10),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetVlanVid }
      Then { result.actions[0].vlan_id == 10 }
    end

    context 'with a SetVlanPriority action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SetVlanPriority.new(3),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetVlanPriority }
      Then { result.actions[0].vlan_priority == 3 }
    end

    context 'with a StripVlanHeader action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::StripVlanHeader.new,
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::StripVlanHeader }
    end

    context 'with a SetSourceMacAddress action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SetSourceMacAddress.new('11:22:33:44:55:66'),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x60 }
      Then { result.actions_len == 0x10 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetSourceMacAddress }
      Then { result.actions[0].mac_address == '11:22:33:44:55:66' }
    end

    context 'with a SetDestinationMacAddress action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SetDestinationMacAddress.new('11:22:33:44:55:66'),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x60 }
      Then { result.actions_len == 0x10 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetDestinationMacAddress }
      Then { result.actions[0].mac_address == '11:22:33:44:55:66' }
    end

    context 'with a SetSourceIpAddress action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SetSourceIpAddress.new('1.2.3.4'),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetSourceIpAddress }
      Then { result.actions[0].ip_address == '1.2.3.4' }
    end

    context 'with a SetDestinationIpAddress action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SetDestinationIpAddress.new('1.2.3.4'),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetDestinationIpAddress }
      Then { result.actions[0].ip_address == '1.2.3.4' }
    end

    context 'with a SetTos action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SetTos.new(32),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetTos }
      Then { result.actions[0].type_of_service == 32 }
    end

    context 'with a SetTransportSourcePort action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SetTransportSourcePort.new(100),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetTransportSourcePort }
      Then { result.actions[0].port == 100 }
    end

    context 'with a SetTransportDestinationPort action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::SetTransportDestinationPort.new(100),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x58 }
      Then { result.actions_len == 0x8 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SetTransportDestinationPort }
      Then { result.actions[0].port == 100 }
    end

    context 'with a Enqueue action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: Pio::OpenFlow10::Enqueue.new(port: 1, queue_id: 2),
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x60 }
      Then { result.actions_len == 0x10 }
      Then { result.actions.length == 1 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::Enqueue }
      Then { result.actions[0].port == 1 }
      Then { result.actions[0].queue_id == 2 }
    end

    context 'with SendOutPort and SetVlanVid action' do
      When(:user_options) do
        {
          transaction_id: 0x16,
          buffer_id: 0xffffffff,
          in_port: 0xffff,
          actions: [Pio::OpenFlow10::SendOutPort.new(2),
                    Pio::OpenFlow10::SetVlanVid.new(10)],
          raw_data: data_dump
        }
      end

      Then { result.message_length == 0x60 }
      Then { result.actions_len == 0x10 }
      Then { result.actions.length == 2 }
      Then { result.actions[0].is_a? Pio::OpenFlow10::SendOutPort }
      Then { result.actions[0].port == 2 }
      Then { result.actions[0].max_length == 2**16 - 1 }
      Then { result.actions[1].is_a? Pio::OpenFlow10::SetVlanVid }
      Then { result.actions[1].vlan_id == 10 }
    end
  end
end
# rubocop:enable LineLength
