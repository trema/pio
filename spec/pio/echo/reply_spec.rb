require 'pio/echo'

describe Pio::Echo::Reply do
  describe '.read' do
    When(:echo_reply) { Pio::Echo::Reply.read(binary) }

    context 'with an echo reply message' do
      Given(:binary) { [1, 3, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then { echo_reply.ofp_version == 1 }
      Then { echo_reply.message_type == Pio::OpenFlow::ECHO_REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 0 }
      Then { echo_reply.xid == 0 }
      Then { echo_reply.user_data.empty? }
      Then { echo_reply.user_data == '' }
      Then { echo_reply.body.empty? }
      Then { echo_reply.body == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 0].pack('C*') }
    end

    context 'with a hello message' do
      Given(:binary) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then do
        echo_reply ==
          Failure(Pio::ParseError, 'Invalid Echo Reply message.')
      end
    end
  end

  describe '.new' do
    context 'with no arguments' do
      When(:echo_reply) { Pio::Echo::Reply.new }

      Then { echo_reply.ofp_version == 1 }
      Then { echo_reply.message_type == Pio::OpenFlow::ECHO_REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 0 }
      Then { echo_reply.xid == 0 }
      Then { echo_reply.user_data.empty? }
      Then { echo_reply.user_data == '' }
      Then { echo_reply.body.empty? }
      Then { echo_reply.body == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 0].pack('C*') }
    end

    context 'with 123' do
      When(:echo_reply) { Pio::Echo::Reply.new(123) }

      Then { echo_reply.ofp_version == 1 }
      Then { echo_reply.message_type == Pio::OpenFlow::ECHO_REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 123 }
      Then { echo_reply.xid == 123 }
      Then { echo_reply.user_data.empty? }
      Then { echo_reply.user_data == '' }
      Then { echo_reply.body.empty? }
      Then { echo_reply.body == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with transaction_id: 123' do
      When(:echo_reply) { Pio::Echo::Reply.new(transaction_id: 123) }

      Then { echo_reply.ofp_version == 1 }
      Then { echo_reply.message_type == Pio::OpenFlow::ECHO_REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 123 }
      Then { echo_reply.xid == 123 }
      Then { echo_reply.user_data.empty? }
      Then { echo_reply.user_data == '' }
      Then { echo_reply.body.empty? }
      Then { echo_reply.body == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with xid: 123' do
      When(:echo_reply) { Pio::Echo::Reply.new(xid: 123) }

      Then { echo_reply.ofp_version == 1 }
      Then { echo_reply.message_type == Pio::OpenFlow::ECHO_REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 123 }
      Then { echo_reply.xid == 123 }
      Then { echo_reply.user_data.empty? }
      Then { echo_reply.user_data == '' }
      Then { echo_reply.body.empty? }
      Then { echo_reply.body == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context "with transaction_id: 123, user_data: 'foobar'" do
      When(:echo_reply) { Pio::Echo::Reply.new(xid: 123, user_data: 'foobar') }

      Then { echo_reply.ofp_version == 1 }
      Then { echo_reply.message_type == Pio::OpenFlow::ECHO_REPLY }
      Then { echo_reply.message_length == 14 }
      Then { echo_reply.transaction_id == 123 }
      Then { echo_reply.xid == 123 }
      Then { echo_reply.user_data == 'foobar' }
      Then { echo_reply.body == 'foobar' }
      Then do
        echo_reply.to_binary ==
          [1, 3, 0, 14, 0, 0, 0, 123, 102, 111, 111, 98, 97, 114].pack('C*')
      end
    end

    context 'with -1' do
      When(:result) { Pio::Echo::Reply.new(-1) }

      Then do
        result ==
          Failure(ArgumentError,
                  'Transaction ID should be an unsigned 32-bit integer.')
      end
    end

    context 'with 2**32' do
      When(:result) { Pio::Echo::Reply.new(2**32) }

      Then do
        result ==
          Failure(ArgumentError,
                  'Transaction ID should be an unsigned 32-bit integer.')
      end
    end

    context 'with :INVALID_ARGUMENT' do
      When(:result) { Pio::Echo::Reply.new(:INVALID_ARGUMENT) }

      Then { result == Failure(TypeError) }
    end
  end
end
