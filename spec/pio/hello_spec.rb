# encoding: utf-8

require 'pio'

describe Pio::Hello do
  describe '.read' do
    context 'with a hello message' do
      Given(:hello_dump) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:hello) { Pio::Hello.read(hello_dump) }

      Then { hello.class == Pio::Hello }
      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.transaction_id == 0 }
      Then { hello.xid == 0 }
      Then { hello.body.empty? }
    end

    context 'with a features-request message' do
      Given(:features_request_dump) { [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:result) { Pio::Hello.read(features_request_dump) }
      Then { result == Failure(BinData::ValidityError) }
    end
  end

  describe '.new' do
    context 'with no arguments' do
      When(:hello) { Pio::Hello.new }

      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.transaction_id == 0 }
      Then { hello.xid == 0 }
      Then { hello.body.empty? }
      Then { hello.to_binary == [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }
    end

    context 'with 123' do
      When(:hello) { Pio::Hello.new(123) }

      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.transaction_id == 123 }
      Then { hello.xid == 123 }
      Then { hello.body.empty? }
      Then { hello.to_binary == [1, 0, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with transaction_id: 123' do
      When(:hello) { Pio::Hello.new(transaction_id: 123) }

      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.transaction_id == 123 }
      Then { hello.xid == 123 }
      Then { hello.body.empty? }
      Then { hello.to_binary == [1, 0, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with xid: 123' do
      When(:hello) { Pio::Hello.new(xid: 123) }

      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.transaction_id == 123 }
      Then { hello.xid == 123 }
      Then { hello.body.empty? }
      Then { hello.to_binary == [1, 0, 0, 8, 0, 0, 0, 123].pack('C*') }
    end
  end
end
