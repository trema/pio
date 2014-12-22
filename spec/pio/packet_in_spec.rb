require 'pio/packet_in'

describe Pio::PacketIn do
  Given(:data_dump) do
    [
      0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xac, 0x5d, 0x10, 0x31,
      0x37, 0x79, 0x08, 0x06, 0x00, 0x01, 0x08, 0x00, 0x06, 0x04,
      0x00, 0x01, 0xac, 0x5d, 0x10, 0x31, 0x37, 0x79, 0xc0, 0xa8,
      0x02, 0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xc0, 0xa8,
      0x02, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    ].pack('C*')
  end

  describe '.read' do
    context 'with a packet_in message' do
      Given(:header_dump) do
        [
          0x01,
          0x0a,
          0x00, 0x4e,
          0x00, 0x00, 0x00, 0x00
        ].pack('C*')
      end
      Given(:body_dump) do
        [
          0xff, 0xff, 0xff, 0x00,
          0x00, 0x3c,
          0x00, 0x01,
          0x00,
          0x00
        ].pack('C*') + data_dump
      end

      When(:packet_in) do
        Pio::PacketIn.read(header_dump + body_dump)
      end

      Then { packet_in.class == Pio::PacketIn }
      Then { packet_in.ofp_version == 0x1 }
      Then { packet_in.message_type == 0xa }
      Then { packet_in.message_length == 0x4e }
      Then { packet_in.transaction_id == 0 }
      Then { packet_in.xid == 0 }

      Then { !packet_in.body.empty? }
      Then { packet_in.buffer_id == 0xffffff00 }
      Then { packet_in.total_len == 0x3c }
      Then { packet_in.in_port == 1 }
      Then { packet_in.reason == :no_match }
      Then { packet_in.data == data_dump }
    end

    context 'with a packet_in message generated with PacketIn.new' do
      Given(:packet_in_dump) do
        Pio::PacketIn.new(
          transaction_id: 0,
          buffer_id: 0xffffff00,
          in_port: 1,
          reason: :no_match,
          data: data_dump
        ).to_binary
      end
      When(:packet_in) { Pio::PacketIn.read(packet_in_dump) }

      Then { packet_in.class == Pio::PacketIn }
      Then { packet_in.ofp_version == 0x1 }
      Then { packet_in.message_type == 0xa }
      Then { packet_in.message_length == 0x4e }
      Then { packet_in.transaction_id == 0 }
      Then { packet_in.xid == 0 }

      Then { !packet_in.body.empty? }
      Then { packet_in.buffer_id == 0xffffff00 }
      Then { packet_in.total_len == 0x3c }
      Then { packet_in.in_port == 1 }
      Then { packet_in.reason == :no_match }
      Then { packet_in.data == data_dump }
    end

    context 'with a Hello message' do
      Given(:hello_dump) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:result) { Pio::PacketIn.read(hello_dump) }

      Then do
        result == Failure(Pio::ParseError, 'Invalid Packet-In message.')
      end
    end
  end

  describe '.new' do
    When(:packet_in) { Pio::PacketIn.new(user_options) }

    context 'with transaction_id: option' do
      When(:user_options) do
        {
          transaction_id: 0x123,
          buffer_id: 0xffffff00,
          in_port: 1,
          reason: :no_match,
          data: data_dump
        }
      end

      Then { packet_in.ofp_version == 1 }
      Then { packet_in.message_type == 10 }
      Then { packet_in.message_length == 78 }
      Then { packet_in.transaction_id == 0x123 }
      Then { packet_in.xid == 0x123 }

      Then { !packet_in.body.empty? }
      Then { packet_in.buffer_id == 0xffffff00 }
      Then { packet_in.in_port == 1 }
      Then { packet_in.reason == :no_match }
      Then { packet_in.data == data_dump }
    end

    context 'with xid: option' do
      When(:user_options) do
        {
          xid: 0x123,
          buffer_id: 0xffffff00,
          in_port: 1,
          reason: :no_match,
          data: data_dump
        }
      end

      Then { packet_in.ofp_version == 1 }
      Then { packet_in.message_type == 10 }
      Then { packet_in.message_length == 78 }
      Then { packet_in.transaction_id == 0x123 }
      Then { packet_in.xid == 0x123 }

      Then { !packet_in.body.empty? }
      Then { packet_in.buffer_id == 0xffffff00 }
      Then { packet_in.in_port == 1 }
      Then { packet_in.reason == :no_match }
      Then { packet_in.data == data_dump }
    end
  end
end
