require 'pio/open_flow13/hello'

describe Pio::Hello do
  describe '.read' do
    When(:result) { Pio::Hello.read(binary) }

    context 'with a hello message (no version bitmap)' do
      Given(:binary) { [4, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then { result.class == Pio::Hello }
      Then { result.ofp_version == 4 }
      Then { result.message_type == 0 }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 0 }
      Then { result.xid == 0 }
      Then { result.supported_versions.empty? }
    end

    context 'with a hello message' do
      Given(:binary) do
        [4, 0, 0, 16, 0, 0, 0, 0, 0, 1, 0, 8, 0, 0, 0, 18].pack('C*')
      end

      Then { result.class == Pio::Hello }
      Then { result.ofp_version == 4 }
      Then { result.message_type == 0 }
      Then { result.message_length == 16 }
      Then { result.transaction_id == 0 }
      Then { result.xid == 0 }
      Then { result.supported_versions == [:open_flow10, :open_flow13] }
    end

    context 'with a hello message (OpenFlow 1.0)' do
      Given(:binary) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then { result == Failure(Pio::ParseError, 'Invalid Hello 1.3 message.') }
    end
  end

  describe '.new' do
    context 'with no arguments' do
      When(:result) { Pio::Hello.new }

      Then { result.ofp_version == 4 }
      Then { result.message_type == 0 }
      Then { result.message_length == 16 }
      Then { result.transaction_id == 0 }
      Then { result.xid == 0 }
      Then { result.supported_versions == [:open_flow13] }
      Then do
        result.to_binary ==
          [4, 0, 0, 16, 0, 0, 0, 0, 0, 1, 0, 8, 0, 0, 0, 16].pack('C*')
      end
    end

    context 'with transaction_id: 123' do
      When(:result) { Pio::Hello.new(transaction_id: 123) }

      Then { result.ofp_version == 4 }
      Then { result.message_type == 0 }
      Then { result.message_length == 16 }
      Then { result.transaction_id == 123 }
      Then { result.xid == 123 }
      Then { result.supported_versions == [:open_flow13] }
      Then do
        result.to_binary ==
          [4, 0, 0, 16, 0, 0, 0, 123, 0, 1, 0, 8, 0, 0, 0, 16].pack('C*')
      end
    end

    context 'with xid: 123' do
      When(:result) { Pio::Hello.new(xid: 123) }

      Then { result.ofp_version == 4 }
      Then { result.message_type == 0 }
      Then { result.message_length == 16 }
      Then { result.transaction_id == 123 }
      Then { result.xid == 123 }
      Then { result.supported_versions == [:open_flow13] }
      Then do
        result.to_binary ==
          [4, 0, 0, 16, 0, 0, 0, 123, 0, 1, 0, 8, 0, 0, 0, 16].pack('C*')
      end
    end

    context 'with xid: -1' do
      When(:result) { Pio::Hello.new(xid: -1) }

      Then do
        result ==
          Failure(ArgumentError,
                  'Transaction ID should be an unsigned 32-bit integer.')
      end
    end

    context 'with xid: 2**32' do
      When(:result) { Pio::Hello.new(xid: 2**32) }

      Then do
        result ==
          Failure(ArgumentError,
                  'Transaction ID should be an unsigned 32-bit integer.')
      end
    end

    context 'with invalid_keyword: :foo' do
      When(:result) { Pio::Hello.new(invalid_keyword: :foo) }

      Then do
        result == Failure(RuntimeError, 'Unknown keyword: invalid_keyword')
      end
    end
  end
end
