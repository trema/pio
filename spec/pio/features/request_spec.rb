require 'pio/features'

describe Pio::Features::Request do
  describe '.read' do
    When(:result) { Pio::Features::Request.read(binary) }

    context 'with a Features Request message' do
      Given(:binary) { [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then { result.class == Pio::Features::Request }
      Then { result.ofp_version == 1 }
      Then do
        result.message_type ==
          Pio::OpenFlow::Type::FEATURES_REQUEST
      end
      Then { result.message_length == 8 }
      Then { result.transaction_id == 0 }
      Then { result.xid == 0 }
      Then { result.body.empty? }
      Then { result.body == '' }
    end

    context 'with a Hello message' do
      Given(:binary) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then do
        result == Failure(Pio::ParseError,
                          'Invalid Features Request message.')
      end
    end
  end

  describe '.new' do
    context 'with no arguments' do
      When(:result) { Pio::Features::Request.new }

      Then { result.ofp_version == 1 }
      Then { result.message_type == Pio::OpenFlow::Type::FEATURES_REQUEST }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 0 }
      Then { result.xid == 0 }
      Then { result.body.empty? }
      Then { result.body == '' }
      Then { result.to_binary == [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }
    end

    context 'with 123' do
      When(:result) { Pio::Features::Request.new(123) }

      Then { result.ofp_version == 1 }
      Then { result.message_type == Pio::OpenFlow::Type::FEATURES_REQUEST }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 123 }
      Then { result.xid == 123 }
      Then { result.body.empty? }
      Then { result.body == '' }
      Then { result.to_binary == [1, 5, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with transaction_id: 123' do
      When(:result) { Pio::Features::Request.new(transaction_id: 123) }

      Then { result.ofp_version == 1 }
      Then { result.message_type == Pio::OpenFlow::Type::FEATURES_REQUEST }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 123 }
      Then { result.xid == 123 }
      Then { result.body.empty? }
      Then { result.body == '' }
      Then { result.to_binary == [1, 5, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with xid: 123' do
      When(:result) { Pio::Features::Request.new(xid: 123) }

      Then { result.ofp_version == 1 }
      Then { result.message_type == Pio::OpenFlow::Type::FEATURES_REQUEST }
      Then { result.message_length == 8 }
      Then { result.transaction_id == 123 }
      Then { result.xid == 123 }
      Then { result.body.empty? }
      Then { result.body == '' }
      Then { result.to_binary == [1, 5, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with -1' do
      When(:result) { Pio::Features::Request.new(-1) }

      Then do
        result ==
          Failure(ArgumentError,
                  'Transaction ID should be an unsigned 32-bit integer.')
      end
    end

    context 'with 2**32' do
      When(:result) { Pio::Features::Request.new(2**32) }

      Then do
        result ==
          Failure(ArgumentError,
                  'Transaction ID should be an unsigned 32-bit integer.')
      end
    end

    context 'with :INVALID_ARGUMENT' do
      When(:result) { Pio::Features::Request.new(:INVALID_ARGUMENT) }

      Then { result == Failure(TypeError) }
    end
  end
end
