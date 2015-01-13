require 'pio/hello'

describe Pio::Hello do
  describe '.read' do
    context 'with a hello message' do
      Given(:hello_dump) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:result) { Pio::Hello.read(hello_dump) }

      Then { result.class == Pio::Hello }
      Then { result.ofp_version == 1 }
      Then { result.message_type == 0 }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 0 }
      Then { result.xid == 0 }
      Then { result.body.empty? }
      Then { result.body == '' }
    end

    context 'with a features-request message' do
      Given(:features_request_dump) { [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:result) { Pio::Hello.read(features_request_dump) }

      Then { result == Failure(Pio::ParseError, 'Invalid Hello message.') }
    end
  end

  describe '.new' do
    context 'with no arguments' do
      When(:result) { Pio::Hello.new }

      Then { result.ofp_version == 1 }
      Then { result.message_type == 0 }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 0 }
      Then { result.xid == 0 }
      Then { result.body.empty? }
      Then { result.body == '' }
      Then { result.to_binary == [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }
    end

    context 'with 123' do
      When(:result) { Pio::Hello.new(123) }

      Then { result.ofp_version == 1 }
      Then { result.message_type == 0 }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 123 }
      Then { result.xid == 123 }
      Then { result.body.empty? }
      Then { result.body == '' }
      Then { result.to_binary == [1, 0, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with transaction_id: 123' do
      When(:result) { Pio::Hello.new(transaction_id: 123) }

      Then { result.ofp_version == 1 }
      Then { result.message_type == 0 }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 123 }
      Then { result.xid == 123 }
      Then { result.body.empty? }
      Then { result.body == '' }
      Then { result.to_binary == [1, 0, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with xid: 123' do
      When(:result) { Pio::Hello.new(xid: 123) }

      Then { result.ofp_version == 1 }
      Then { result.message_type == 0 }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 123 }
      Then { result.xid == 123 }
      Then { result.body.empty? }
      Then { result.body == '' }
      Then { result.to_binary == [1, 0, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with -1' do
      When(:result) { Pio::Hello.new(-1) }

      Then do
        result ==
          Failure(ArgumentError,
                  'Transaction ID should be an unsigned 32-bit integer.')
      end
    end

    context 'with 2**32' do
      When(:result) { Pio::Hello.new(2**32) }

      Then do
        result ==
          Failure(ArgumentError,
                  'Transaction ID should be an unsigned 32-bit integer.')
      end
    end

    context 'with :INVALID_ARGUMENT' do
      When(:result) { Pio::Hello.new(:INVALID_ARGUMENT) }

      Then { result == Failure(TypeError) }
    end
  end
end
