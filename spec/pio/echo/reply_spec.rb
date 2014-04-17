# encoding: utf-8

require 'pio'

describe Pio::Echo::Reply do
  describe '.new' do
    context 'with no arguments' do
      When(:echo_reply) { Pio::Echo::Reply.new }

      Then { echo_reply.version == 1 }
      Then { echo_reply.message_type == Pio::Echo::REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 0 }
      Then { echo_reply.xid == 0 }
      Then { echo_reply.data == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 0].pack('C*') }
    end

    context 'with 123' do
      When(:echo_reply) { Pio::Echo::Reply.new(123) }

      Then { echo_reply.version == 1 }
      Then { echo_reply.message_type == Pio::Echo::REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 123 }
      Then { echo_reply.xid == 123 }
      Then { echo_reply.data == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with 2**32' do
      When(:result) { Pio::Echo::Reply.new(2**32) }

      Then do
        pending 'check if xid is within 32bit range.'
        result == Failure(ArgumentError)
      end
    end

    context 'with transaction_id: 123' do
      When(:echo_reply) { Pio::Echo::Reply.new(transaction_id: 123) }

      Then { echo_reply.version == 1 }
      Then { echo_reply.message_type == Pio::Echo::REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 123 }
      Then { echo_reply.xid == 123 }
      Then { echo_reply.data == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with xid: 123' do
      When(:echo_reply) { Pio::Echo::Reply.new(xid: 123) }

      Then { echo_reply.version == 1 }
      Then { echo_reply.message_type == Pio::Echo::REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.transaction_id == 123 }
      Then { echo_reply.xid == 123 }
      Then { echo_reply.data == '' }
      Then { echo_reply.to_binary == [1, 3, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context "with transaction_id: 123, data: 'foobar'" do
      When(:echo_reply) { Pio::Echo::Reply.new(xid: 123, data: 'foobar') }

      Then { echo_reply.version == 1 }
      Then { echo_reply.message_type == Pio::Echo::REPLY }
      Then { echo_reply.message_length == 14 }
      Then { echo_reply.transaction_id == 123 }
      Then { echo_reply.xid == 123 }
      Then { echo_reply.data == 'foobar' }
      Then do
        echo_reply.to_binary ==
          [1, 3, 0, 14, 0, 0, 0, 123, 102, 111, 111, 98, 97, 114].pack('C*')
      end
    end

    context 'with :INVALID_ARGUMENT' do
      When(:result) { Pio::Echo::Reply.new(:INVALID_ARGUMENT) }

      Then { result == Failure(TypeError) }
    end
  end
end
