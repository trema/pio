# encoding: utf-8

require 'pio'

describe Pio::Features::Request do
  describe '.new' do
    context 'with no arguments' do
      When(:request) { Pio::Features::Request.new }

      Then { request.ofp_version == 1 }
      Then { request.message_type == Pio::Features::REQUEST }
      Then { request.message_length == 8 }
      Then { request.transaction_id == 0 }
      Then { request.xid == 0 }
      Then { request.body == '' }
      Then { request.to_binary == [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }
    end

    context 'with 123' do
      When(:request) { Pio::Features::Request.new(123) }

      Then { request.ofp_version == 1 }
      Then { request.message_type == Pio::Features::REQUEST }
      Then { request.message_length == 8 }
      Then { request.transaction_id == 123 }
      Then { request.xid == 123 }
      Then { request.body == '' }
      Then { request.to_binary == [1, 5, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with 2**32' do
      When(:result) { Pio::Features::Request.new(2**32) }

      Then do
        pending 'check if xid is within 32bit range.'
        result == Failure(ArgumentError)
      end
    end

    context 'with transaction_id: 123' do
      When(:request) { Pio::Features::Request.new(transaction_id: 123) }

      Then { request.ofp_version == 1 }
      Then { request.message_type == Pio::Features::REQUEST }
      Then { request.message_length == 8 }
      Then { request.transaction_id == 123 }
      Then { request.xid == 123 }
      Then { request.body == '' }
      Then { request.to_binary == [1, 5, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with xid: 123' do
      When(:request) { Pio::Features::Request.new(xid: 123) }

      Then { request.ofp_version == 1 }
      Then { request.message_type == Pio::Features::REQUEST }
      Then { request.message_length == 8 }
      Then { request.transaction_id == 123 }
      Then { request.xid == 123 }
      Then { request.body == '' }
      Then { request.to_binary == [1, 5, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with :INVALID_ARGUMENT' do
      When(:result) { Pio::Features::Request.new(:INVALID_ARGUMENT) }

      Then { result == Failure(TypeError) }
    end
  end
end
