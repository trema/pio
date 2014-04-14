# encoding: utf-8

require 'pio'

describe Pio::Hello do
  describe '.read' do
    context 'with an hello message' do
      Given(:hello_dump) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:hello) { Pio::Hello.read(hello_dump) }

      Then { hello.class == Pio::Hello }
      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.xid == 0 }
      Then { hello.body.empty? }
    end
  end

  describe '.new' do
    context 'with no arguments' do
      When(:hello) { Pio::Hello.new }

      Then { hello.class == Pio::Hello }
      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.xid == 0 }
      Then { hello.body.empty? }
      Then { hello.to_binary_s == [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }
    end

    context 'with transaction_id: 123' do
      When(:hello) { Pio::Hello.new(transaction_id: 123) }

      Then { hello.class == Pio::Hello }
      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.xid == 123 }
      Then { hello.body.empty? }
      Then { hello.to_binary_s == [1, 0, 0, 8, 0, 0, 0, 123].pack('C*') }
    end

    context 'with xid: 123' do
      When(:hello) { Pio::Hello.new(xid: 123) }

      Then { hello.class == Pio::Hello }
      Then { hello.version == 1 }
      Then { hello.message_type == 0 }
      Then { hello.message_length == 8 }
      Then { hello.xid == 123 }
      Then { hello.body.empty? }
      Then { hello.to_binary_s == [1, 0, 0, 8, 0, 0, 0, 123].pack('C*') }
    end
  end
end
